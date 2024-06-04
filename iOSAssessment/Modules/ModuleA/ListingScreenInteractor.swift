//
//  ListingScreen.swift
//  iOSAssessment
//
//  Created by Nikunj Munjiyasara on 04/06/24.
//


import Foundation
import RealmSwift

protocol ListingScreenProtocol {
    func fetchData()
}

class ListingScreen: ListingScreenProtocol {
    var presenter: ListingScreenPresenterProtocol?
    
    func fetchData() {
        print("In fetchData")
        let url = URL(string: "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates")!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                self?.fetchFromLocalDB()
                return
            }
            
            guard let data = data else {
                print("No data received")
//                self?.presenter?.dataFetchFailed()
                self?.fetchFromLocalDB()
                return
            }
            
            do {
                let universities = try JSONDecoder().decode([University].self, from: data)
                self?.saveToLocalDB(universities)
                let universityDTOs = universities.map { UniversityDTO(university: $0) }
                                self?.presenter?.dataFetchedSuccessfully(universities: universityDTOs)
                print("In universities \(universities)")
            } catch let decodingError {
                print("Decoding error: \(decodingError.localizedDescription)")
                self?.presenter?.dataFetchFailed()
            }
        }
        task.resume()
    }
    
    private func saveToLocalDB(_ universities: [University]) {
           DispatchQueue.global(qos: .background).async {
               autoreleasepool {
                   do {
                       let realm = try Realm()
                       try realm.write {
                           realm.add(universities, update: .all)
                       }
                       print("Saved universities to local DB")
                   } catch {
                       print("Error saving to local DB: \(error.localizedDescription)")
                   }
               }
           }
       }
    
    private func fetchFromLocalDB() {
          DispatchQueue.global(qos: .background).async {
              autoreleasepool {
                  do {
                      let realm = try Realm()
                      let universities = realm.objects(University.self)
                                          
                      
                                          let universityDTOs = universities.map { UniversityDTO(university: $0) }
                                          let universityArray = Array(universityDTOs)
                                          DispatchQueue.main.async { [weak self] in
                                              if !universityArray.isEmpty {
                                                  self?.presenter?.dataFetchedSuccessfully(universities: universityArray)
                                              } else {
                                                  self?.presenter?.dataFetchFailed()
                                              }
                                          }
                  } catch {
                      print("Error fetching from local DB: \(error.localizedDescription)")
                  }
              }
          }
      }
}

