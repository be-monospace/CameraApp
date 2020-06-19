//
//  UIViewController_Extensions.swift
//  CamApp
//
//  Created by Beatriz Novais on 19/06/2020.
//  Copyright © 2020 Beatriz Novais. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addChildController(_ childVC: UIViewController) {
        self.addChild(childVC)
        childVC.view.frame = self.view.frame
        self.view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
    
}
