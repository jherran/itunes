//
//  Records.swift
//  itunes
//
//  Created by Jose A. Herran on 21/10/2017.
//  Copyright © 2017 Jose A. Herran. All rights reserved.
//

import Foundation

struct Record: Codable {
    var resultCount: Int
    var results: [ListRecord]
    
    static func endpoint() -> String {
        return "https://itunes.apple.com/lookup?entity=album&id="
    }
}

struct ListRecord: Codable {
    var wrapperType: String
    var artistId: Int
    var artistName: String
    var collectionName: String?
    var artworkUrl60: String?
    var releaseDate: String?
}
