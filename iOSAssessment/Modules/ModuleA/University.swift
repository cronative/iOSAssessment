//
//  University.swift
//  iOSAssessment
//
//  Created by Nikunj Munjiyasara on 04/06/24.
//

import Foundation
import RealmSwift

class University: Object, Codable {
    @objc dynamic var id: String = UUID().uuidString // Use a UUID for a unique primary key
    @objc dynamic var alphaTwoCode: String = ""
    var domains = List<String>()
    @objc dynamic var name: String = ""
    var webPages = List<String>()
    @objc dynamic var country: String = ""
    @objc dynamic var stateProvince: String?

    override static func primaryKey() -> String? {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case alphaTwoCode = "alpha_two_code"
        case domains
        case name
        case webPages = "web_pages"
        case country
        case stateProvince = "state-province"
    }
    
    required override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        alphaTwoCode = try container.decode(String.self, forKey: .alphaTwoCode)
        let domainsArray = try container.decode([String].self, forKey: .domains)
        domains.append(objectsIn: domainsArray)
        name = try container.decode(String.self, forKey: .name)
        let webPagesArray = try container.decode([String].self, forKey: .webPages)
        webPages.append(objectsIn: webPagesArray)
        country = try container.decode(String.self, forKey: .country)
        stateProvince = try container.decodeIfPresent(String.self, forKey: .stateProvince)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(alphaTwoCode, forKey: .alphaTwoCode)
        try container.encode(Array(domains), forKey: .domains)
        try container.encode(name, forKey: .name)
        try container.encode(Array(webPages), forKey: .webPages)
        try container.encode(country, forKey: .country)
        try container.encode(stateProvince, forKey: .stateProvince)
    }
}


struct UniversityDTO {
    let id: String
    let alphaTwoCode: String
    let domains: [String]
    let name: String
    let webPages: [String]
    let country: String
    let stateProvince: String?
    
    init(university: University) {
        self.id = university.id
        self.alphaTwoCode = university.alphaTwoCode
        self.domains = Array(university.domains)
        self.name = university.name
        self.webPages = Array(university.webPages)
        self.country = university.country
        self.stateProvince = university.stateProvince
    }
}
