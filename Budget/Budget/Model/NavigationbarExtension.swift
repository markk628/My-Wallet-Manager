//
//  NavigationbarExtension.swift
//  Budget
//
//  Created by Mark Kim on 7/26/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func initRootViewController(vc: UIViewController, transitionType type: String = "kCATransitionFade", duration: CFTimeInterval = 0.3, navbarHidden: Bool) {
        self.addTransition(transitionType: type, duration: duration)
        self.viewControllers.removeAll()
        self.pushViewController(vc, animated: false)
        self.popViewController(animated: false)
        self.navigationBar.isHidden = navbarHidden
    }
    
    private func addTransition(transitionType type: String = "kCATransitionFade", duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType(rawValue: type)
        self.view.layer.add(transition, forKey: nil)
    }
}
