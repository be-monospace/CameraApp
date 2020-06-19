//
//  PhotoListCollectionViewController.swift
//  CamApp
//
//  Created by Beatriz Novais on 19/06/2020.
//  Copyright © 2020 Beatriz Novais. All rights reserved.
//

import Foundation
import UIKit
import Photos

protocol PhotoListCollectionViewControllerDelegate {
    func photoListDidSelectImage(selectedImage: UIImage)
}

class PhotoListCollectionViewController: UICollectionViewController {
    
    private var images = [PHAsset]()
    var delegate: PhotoListCollectionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    
    // autorização para utilizar as fotos (info.plist extra)
    private func requestPermission(completion: @escaping (PHAuthorizationStatus) -> ()) {
        PHPhotoLibrary.requestAuthorization {
            status in DispatchQueue.main.async {
                completion(status)
            }
        }
    }
    
    
    //populate cells with photos - collection view
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    //selecionar foto/ cell from collection view - grab selected image
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        
        let options = PHImageRequestOptions()
        options.isSynchronous = true // Why? - get image while freezing the frame, optional
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 320, height: 480), contentMode: .aspectFill, options: options) { (image, _) in
            
            if let image = image {
                self.delegate?.photoListDidSelectImage(selectedImage: image)
            }
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell
            else {
            fatalError("PhotoCollectionViewCell was not found")
            }
        
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil) { (image, _) in
            
            DispatchQueue.main.async {
                cell.photoImageView.image = image
            }
            
        }

        return cell
    }
    
    
    
    
    private func populatePhotos() {
        
        requestPermission { [weak self] status in
            
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
            
                self?.images.reverse() //start from newst photo to oldest
                self?.collectionView.reloadData()
        
            }
        }
    }
    
}
