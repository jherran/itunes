//
//  ListInteractor.swift
//  itunes
//
//  Created by Jose A. Herran on 20/10/2017.
//  Copyright © 2017 Jose A. Herran. All rights reserved.
//

import Foundation

protocol ListInteractorOutput: class {
    func retrievedList(result: [ListArtist])
    func couldNotRetrieveList(error: String?)
}

class ListInteractor: NSObject {
    
    weak var delegateOutput: ListInteractorOutput?    
    
    func getListFromiTunesWith(term: String) {
        let endpoint = List.endpoint() + term.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: endpoint) else {
            self.delegateOutput?.couldNotRetrieveList(error: "Error: cannot create URL")
            return
        }

        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                self.delegateOutput?.couldNotRetrieveList(error: error?.localizedDescription)
                return
            }
            guard let responseData = data else {
                self.delegateOutput?.couldNotRetrieveList(error: "Error: did not receive data")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                var list = try decoder.decode(List.self, from: responseData)
                for i in 0...list.results.count - 1 {
                    self.getRecordListFromiTunesWith(id: list.results[i].artistId, completion: { (discography) in
                        list.results[i].discography = discography
                        self.delegateOutput?.retrievedList(result: list.results)
                    })
                }
            } catch {
                self.delegateOutput?.couldNotRetrieveList(error: "Error: trying to convert data to JSON")
            }
        })
        task.resume()
    }
    
    func getRecordListFromiTunesWith(id: Int, completion: @escaping ([ListRecord]?) -> ())  {
        let endpoint = Record.endpoint() + "\(id)"
        guard let url = URL(string: endpoint) else {
            completion(nil)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            guard let responseData = data else {
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                var record = try decoder.decode(Record.self, from: responseData)
                if record.resultCount > 0 && record.results[0].wrapperType == "artist" {
                    record.results.remove(at: 0)
                    completion(record.results)
                }
            } catch {
                completion(nil)
                return
            }
        })
        task.resume()
    }
}
