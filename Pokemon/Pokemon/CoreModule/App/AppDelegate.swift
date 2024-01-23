//
//  AppDelegate.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 20.01.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var applicationCoordinator: AppCoordinatorProtocol?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = UINavigationController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        let factory = App.CoordinatorFactory(navController: rootViewController)
        applicationCoordinator = App.Coordinator(factory: factory,
                                                 rootNavController: rootViewController)
        applicationCoordinator?.startApplication()

        return true
    }
}

