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
    
    var imageAssetName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        
        guard let image = UIImage(named: imageAssetName) else { return }
        imageView.image = image
    }
    @IBAction func zoomPhoto(_ sender: Any) {
        switch imageView.contentMode {
        case .scaleAspectFit:
            UIView.transition(with: imageView, duration: 0.15, options: [.curveLinear,.transitionCrossDissolve], animations: {self.imageView.contentMode = .scaleAspectFill}, completion: nil)
        case .scaleAspectFill:
            UIView.transition(with: imageView, duration: 0.15, options: [.curveLinear,.transitionCrossDissolve], animations: {self.imageView.contentMode = .scaleAspectFit}, completion: nil)
        default:
            preconditionFailure("Incorrect contentMode for ImageView")
        }
    }
}
