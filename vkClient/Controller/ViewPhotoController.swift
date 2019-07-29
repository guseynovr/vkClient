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
            imageView.contentMode = .scaleAspectFill
            #warning("No animation")
//            UIImageView.animate(withDuration: 2) {
//                self.imageView.contentMode = .scaleAspectFill
//            }
        case .scaleAspectFill:
            imageView.contentMode = .scaleAspectFit
        default:
            preconditionFailure("Incorrect contentMode for ImageView")
        }
    }
}
