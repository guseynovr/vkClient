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
    
    var isZoomed = false

    var imageAssetName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bringSubviewToFront(loadingIndicator)
        tabBarController?.tabBar.isHidden = true
        
        guard let image = UIImage(named: imageAssetName) else { return }
        imageView.image = image
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
