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
    
    var isZoomed = false {
        didSet {
            UIView.animate(withDuration: 0.5) {
                self.imageView.bounds = CGRect(
                    x: self.imageView.bounds.origin.x,
                    y: self.imageView.bounds.origin.y,
                    width: self.isZoomed ? self.imageView.bounds.size.width * 1.7 : self.imageView.bounds.size.width / 1.7,
                    height: self.isZoomed ? self.imageView.bounds.size.height * 1.7 : self.imageView.bounds.size.height / 1.7)
            }
        }
    }

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
    }
}
