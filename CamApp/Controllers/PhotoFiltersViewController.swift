//
//  PhotoFiltersViewController.swift
//  CamApp
//
//  Created by Beatriz Novais on 19/06/2020.
//  Copyright © 2020 Beatriz Novais. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoFilterViewControllerDelegate {
    func photoFilterDone()
    func photoFilterCancel()
}

class PhotoFiltersViewController: UIViewController, FiltersScrollViewDelegate {
    
    var image: UIImage?
    private var filtersService: FiltersService!
    
    var delegate: PhotoFilterViewControllerDelegate?
    
    @IBOutlet weak var filtersScrollView: FiltersScrollView! 
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func cancelButtonPressed() {
        self.delegate?.photoFilterCancel()
        
    }
    @IBAction func doneButtonPressed() {
        guard let selectedImage = self.photoImageView.image else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            print(error.localizedDescription)
        } else {
            self.delegate?.photoFilterDone()
        }
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
