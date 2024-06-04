//
//  DetailsRouter.swift
//  iOSAssessment
//
//  Created by Nikunj Munjiyasara on 04/06/24.
//

import Foundation
import UIKit

protocol DetailScreenRouterProtocol {
    func dismissDetailScreenAndRefreshListingScreen()
}

class DetailScreenRouter: DetailScreenRouterProtocol {
    weak var viewController: UIViewController?

    static func createModule(with data: UniversityDTO) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "DetailScreenView") as! DetailScreenView
        let presenter = DetailScreenPresenter()
        let interactor = DetailScreenInteractor()
        let router = DetailScreenRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.university = data
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func dismissDetailScreenAndRefreshListingScreen() {
            viewController?.navigationController?.popViewController(animated: true)
            if let navigationController = viewController?.navigationController,
               let listingViewController = navigationController.viewControllers.first as? ListingScreenView {
                LoadingOverlay.shared.showOverlay(view: listingViewController.view)
                listingViewController.presenter?.fetchData()
            }
        }
}
