//
//  UIViewPhotoController.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 08/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class ViewPhotoController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingIndicator: LoadingIndicator!
    
    var imageViewLeft = UIImageView()
    var imageViewRight = UIImageView()
    
    var isZoomed = false

    var selectedImageId: Int!
    var userPhotosNames: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bringSubviewToFront(loadingIndicator)
        tabBarController?.tabBar.isHidden = true
        
        setImages()
        
        view.addSubview(imageViewLeft)
        view.addSubview(imageViewRight)
    }
    
    fileprivate func setImages() {
        guard let image = UIImage(named: userPhotosNames[selectedImageId]) else {
            preconditionFailure("wrong image asset name")
        }
        imageView.image = image
        
        if userPhotosNames.indices.contains(selectedImageId - 1) {
            imageViewLeft.image = UIImage(named: userPhotosNames[selectedImageId - 1])
        }
        if userPhotosNames.indices.contains(selectedImageId + 1) {
            imageViewRight.image = UIImage(named: userPhotosNames[selectedImageId + 1])
        }
    }
    
    @IBAction func zoomPhoto(_ sender: Any) {
        isZoomed.toggle()
        
        UIView.animate(withDuration: 0.5) {
            if self.isZoomed {
                self.imageView.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
            } else {
                self.imageView.transform = .identity
            }
        }
    }
}
