//
//  ListingScreenPresenter.swift
//  iOSAssessment
//
//  Created by Nikunj Munjiyasara on 04/06/24.
//

import Foundation

protocol ListingScreenPresenterProtocol {
    func fetchData()
    func refreshData()
    func dataFetchedSuccessfully(universities: [UniversityDTO])
    func dataFetchFailed()
}

class ListingScreenPresenter: ListingScreenPresenterProtocol {
    var view: ListingScreenViewProtocol?
    var interactor: ListingScreenProtocol?
    var router: ListingScreenRouterProtocol?

    func fetchData() {
        interactor?.fetchData()
    }
    func refreshData() {
           interactor?.fetchData()
       }
    
    func dataFetchedSuccessfully(universities: [UniversityDTO]) {
        view?.showData(universities: universities)
    }
    
    func dataFetchFailed() {
        view?.showError()
    }
}
