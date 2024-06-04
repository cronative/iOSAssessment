//
//  AppDelegate.swift
//  iOSAssessment
//
//  Created by Nikunj Munjiyasara on 04/06/24.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        setupRealm()
           window = UIWindow(frame: UIScreen.main.bounds)
        let initialViewController = ListingScreenRouter.createModule()

        //           window?.rootViewController = ListingScreenRouter.createModule()
//           window?.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: initialViewController)

               window = UIWindow(frame: UIScreen.main.bounds)
               window?.rootViewController = navigationController
               window?.makeKeyAndVisible()
           return true
       }
    
    func setupRealm() {
        let config = Realm.Configuration(
            schemaVersion: 1, // Increment this number whenever you make a schema change
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    // Perform migrations for any schema changes if needed
                    migration.enumerateObjects(ofType: University.className()) { oldObject, newObject in
                        // Automatically adds new properties with default values
                        newObject!["alphaTwoCode"] = oldObject?["alphaTwoCode"] as? String ?? ""
                        newObject!["domains"] = oldObject?["domains"] as? List<String> ?? List<String>()
                        newObject!["stateProvince"] = oldObject?["stateProvince"] as? String ?? nil
                    }
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
        // Now Realm() instances will use this configuration
    }



}

