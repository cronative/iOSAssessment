//
//  DetailsPresenter.swift
//  iOSAssessment
//
//  Created by Nikunj Munjiyasara on 04/06/24.
//

import Foundation

protocol DetailScreenPresenterProtocol {
    func viewDidLoad()
    
    func refreshButtonTapped()
}

class DetailScreenPresenter: DetailScreenPresenterProtocol {
  
    
    var view: DetailScreenViewProtocol?
    var interactor: DetailScreenInteractorProtocol?
    var router: DetailScreenRouterProtocol?
    var university: UniversityDTO?

    func viewDidLoad() {
        
                view?.showData(with: university)
        
    }
    func refreshButtonTapped() {
            router?.dismissDetailScreenAndRefreshListingScreen()
        }
    
}
