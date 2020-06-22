//
//  PhotoFiltersViewController.swift
//  CamApp
//
//  Created by Beatriz Novais on 19/06/2020.
//  Copyright © 2020 Beatriz Novais. All rights reserved.
//

import Foundation
import UIKit

class PhotoFiltersViewController: UIViewController, FiltersScrollViewDelegate {
    
    var image: UIImage?
    private var filtersService: FiltersService!
    
    @IBOutlet weak var filtersScrollView: FiltersScrollView! 
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func filterScrollViewDidSelectFilter(filter: CIFilter) {
        self.filtersService.applyFilter(filter: filter, to: self.image!) {
            self.photoImageView.image = $0
        }
    }
    
    private func setupUI() {
        
        self.filtersService =  FiltersService()
        self.filtersScrollView.filterDelegate = self
        self.photoImageView.image = self.image
    }
}
