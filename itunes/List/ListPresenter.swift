//
//  ListPresenter.swift
//  itunes
//
//  Created by Jose A. Herran on 20/10/2017.
//  Copyright © 2017 Jose A. Herran. All rights reserved.
//

import Foundation
import UIKit

protocol ListPresenterOutput: class {
    func listRetrieved()
    func listError(error: String?)
}

class ListPresenter: ListInteractorOutput {
    
    var router: ListRouter?
    var interactor: ListInteractor?

    var listArray: [ListArtist] = []

    weak var delegateOutput: ListPresenterOutput?

    func getListWith(term: String) {
        interactor?.getListFromiTunesWith(term: term)
    }
    
    func goToDetailWith(artist: ListArtist) {
        router?.showListDetailFor(artist: artist)
    }
    
    func retrievedList(result: [ListArtist]) {
        listArray = result
        delegateOutput?.listRetrieved()
    }
    
    func couldNotRetrieveList(error: String?) {
        delegateOutput?.listError(error: error)
    }
}
