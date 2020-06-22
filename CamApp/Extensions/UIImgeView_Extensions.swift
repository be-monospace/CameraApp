//
//  UIImgeView_Extensions.swift
//  CamApp
//
//  Created by Beatriz Novais on 21/06/20.
//  Copyright © 2020 Beatriz Novais. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    static func imageForFilterView() -> UIImageView {
        
        let filterImageView = UIImageView(image: UIImage(named: "placeholder"))
        filterImageView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 80, height: 80))
        filterImageView.layer.cornerRadius = 6.0
        filterImageView.layer.masksToBounds = true
        return filterImageView
    }
    
}
