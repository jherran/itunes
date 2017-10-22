//
//  ListRouter.swift
//  itunes
//
//  Created by Jose A. Herran on 20/10/2017.
//  Copyright © 2017 Jose A. Herran. All rights reserved.
//

import Foundation
import UIKit


class ListRouter {
    
    var viewController: UIViewController!
    
    func showListDetailFor(artist: ListArtist) {
        viewController.performSegue(withIdentifier: "ShowDetailSegue", sender: ["artist": artist])
    }
}

extension ListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController {
            let viewController = navigationController.topViewController as! DetailViewController
            if let dic = sender as? Dictionary<String, AnyObject> {
                DetailConfigurator.sharedInstance.configure(viewController: viewController, artist: dic["artist"] as! ListArtist)
            }
        } else if let viewController = segue.destination as? DetailViewController {
            if let dic = sender as? Dictionary<String, AnyObject> {
                DetailConfigurator.sharedInstance.configure(viewController: viewController, artist: dic["artist"] as! ListArtist)
            }
        }
    }
}
