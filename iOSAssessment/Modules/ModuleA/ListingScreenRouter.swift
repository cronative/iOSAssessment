//
//  ListingScreenRouter.swift
//  iOSAssessment
//
//  Created by Nikunj Munjiyasara on 04/06/24.
//

import UIKit


protocol ListingScreenRouterProtocol {
    func navigateToDetailScreen(from view: UIViewController, with data: UniversityDTO)
}

class ListingScreenRouter: ListingScreenRouterProtocol {
    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "ListingScreenView") as! ListingScreenView
        let presenter = ListingScreenPresenter()
        let interactor = ListingScreen()
        let router = ListingScreenRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToDetailScreen(from view: UIViewController, with data: UniversityDTO) {
        // Navigate to detail screen (Module B) implementation here
        let detailView = DetailScreenRouter.createModule(with: data)
               view.navigationController?.pushViewController(detailView, animated: true)
    }
}

