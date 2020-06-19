//
//  PhotoPreviewViewController.swift
//  CamApp
//
//  Created by Beatriz Novais on 19/06/2020.
//  Copyright © 2020 Beatriz Novais. All rights reserved.
//

import Foundation
import UIKit

class PhotoPreviewViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var previewImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoImageView.image = self.previewImage
    }
    
}
