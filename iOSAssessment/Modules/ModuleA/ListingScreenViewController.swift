//
//  ListingScreenViewController.swift
//  iOSAssessment
//
//  Created by Nikunj Munjiyasara on 04/06/24.
//

import Foundation
import UIKit

protocol ListingScreenViewProtocol {
    func showData(universities: [UniversityDTO])
    func showError()
}

class ListingScreenView: UIViewController, ListingScreenViewProtocol {
 
    
    var presenter: ListingScreenPresenterProtocol?
    var universities: [UniversityDTO] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.fetchData()
        LoadingOverlay.shared.showOverlay(view: self.view)
    }
    
    
    func showData(universities: [UniversityDTO]) {
        self.universities = universities
        print("self.universities >>>>> \(self.universities)")
        DispatchQueue.main.async {
            LoadingOverlay.shared.hideOverlayView()
            self.tableView.reloadData()
        }
    }
    
    func showError() {
        // Show error message
    }

    private func setupUI() {
        title = "Universities"
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.register(UniversityCell.self, forCellReuseIdentifier: "UniversityCell")

    }
}

extension ListingScreenView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UniversityCell", for: indexPath) as! UniversityCell
        cell.configure(with: universities[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let university = universities[indexPath.row]
        navigateToDetailScreen(from: self, with: university);
    
    }
    func navigateToDetailScreen(from view: UIViewController, with data: UniversityDTO) {
            let detailView = DetailScreenRouter.createModule(with: data)
            view.navigationController?.pushViewController(detailView, animated: true)
        }
}

class UniversityCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with university: UniversityDTO) {
        nameLabel.text = university.name
        countryLabel.text = university.stateProvince != nil ? "\(university.stateProvince!), \(university.country)" : university.country
    }
}
