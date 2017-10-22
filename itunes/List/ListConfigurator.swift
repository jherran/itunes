//
//  ListConfigurator.swift
//  itunes
//
//  Created by Jose A. Herran on 20/10/2017.
//  Copyright © 2017 Jose A. Herran. All rights reserved.
//

import Foundation

import UIKit

class ListConfigurator: NSObject {
    
    public static let sharedInstance: ListConfigurator = {
        let instance = ListConfigurator()
        return instance
    }()
    
    func configure(viewController: UIViewController) {
        let viewController = viewController as! ListViewController
        
        // Router
        let router = ListRouter()
        router.viewController = viewController
        
        // Presenter
        let presenter = ListPresenter()
        presenter.router = router
        viewController.presenter = presenter
        
        // Interactor
        let interactor = ListInteractor()
        presenter.interactor = interactor
        
        // MARK: - Delegates output
        presenter.delegateOutput = viewController
        interactor.delegateOutput = presenter
    }
    
}
