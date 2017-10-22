//
//  DetailConfigurator.swift
//  itunes
//
//  Created by Jose A. Herran on 11/10/2017.
//  Copyright © 2017 Jose A. Herran. All rights reserved.
//

import Foundation
import UIKit

class DetailConfigurator: NSObject {
    
    public static let sharedInstance: DetailConfigurator = {
        let instance = DetailConfigurator()
        return instance
    }()
    
    func configure(viewController: UIViewController, artist: ListArtist) {
        let viewController = viewController as! DetailViewController
        viewController.artist = artist
    }
    
}
