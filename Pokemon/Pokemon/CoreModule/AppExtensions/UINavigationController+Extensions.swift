//
//  UINavigationController+Extensions.swift
//  Pokemon
//
//  Created by Ivan Kazantsev on 20.01.2024.
//

import UIKit

extension UINavigationController {

    /// Получить верхний активный UINavigationController
    /// - Returns: Верхний контроллер
    static func uppenNavController() -> UINavigationController? {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        var topViewController = window?.rootViewController

        if let presentedViewController = topViewController?.presentedViewController {
            topViewController = presentedViewController
        }

        if let tabBarController = topViewController as? UITabBarController {
            topViewController = tabBarController.selectedViewController
        }

        if let navigationController = topViewController as? UINavigationController,
           let top = navigationController.topViewController {
            topViewController = top
        }

        if let controller = topViewController?.navigationController {
            return controller
        }
        return topViewController as? UINavigationController
    }
}

