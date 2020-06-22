//
//  AppContainerViewController.swift
//  CamApp
//
//  Created by Beatriz Novais on 19/06/2020.
//  Copyright © 2020 Beatriz Novais. All rights reserved.
//

import Foundation
import UIKit

class AppContainerViewController: UIViewController, PhotoListCollectionViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photoListCVC = self.children.first as?
            PhotoListCollectionViewController else {
                return
        }
        
        photoListCVC.delegate = self
    }
    
    func photoListDidSelectImage(selectedImage: UIImage) {
        
        showImagePreview(previewImage: selectedImage)
    }
    
    private func showImagePreview(previewImage: UIImage) {
        guard let photoPreviewVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoPreviewViewController") as? PhotoPreviewViewController
            else {
                fatalError("PhotoPreviewViewControllor is not found")
            }
        photoPreviewVC.previewImage = previewImage
        self.navigationController?.pushViewController(photoPreviewVC, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        showPhotoFiltersViewController(for: originalImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func showPhotoFiltersViewController(for image: UIImage) {
        
        guard let photoFiltersVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoFiltersViewController") as? PhotoFiltersViewController else {
            fatalError("PhotoFiltersViewController not found")
        }
        photoFiltersVC.image = image
        self.addChildController(photoFiltersVC)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonPressed() {
        
//        guard let photoFiltersVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoFiltersViewController") as? PhotoFiltersViewController
//            else {
//            fatalError("PhotoFiltersViewController is not found")
//            }
//
//        self.addChildController(photoFiltersVC)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.sourceType = .camera
            imagePickerVC.delegate = self
            self.present(imagePickerVC, animated: true, completion: nil)
        }
//
    }
    
    
}
