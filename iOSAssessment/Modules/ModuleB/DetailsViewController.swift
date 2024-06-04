//
//  DetailsViewController.swift
//  iOSAssessment
//
//  Created by Nikunj Munjiyasara on 04/06/24.
//

import Foundation
import UIKit

protocol DetailScreenViewProtocol {
    func showData(with university: UniversityDTO?)
}

class DetailScreenView: UIViewController, DetailScreenViewProtocol {
    var presenter: DetailScreenPresenterProtocol?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var webPagesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    @IBAction func onClickRefresh(sender: UIButton){
//        self.navigationController?.popViewController(animated: true)
        presenter?.refreshButtonTapped()
    }


    func showData(with university: UniversityDTO?) {
        guard let university = university else { return }
        nameLabel.text = university.name
        countryLabel.text = university.country
        webPagesLabel.text = university.webPages.joined(separator: ", ")
    }

    private func setupUI() {
        title = "University Details"
    }
}
