//
//  FriendsPhotosController.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 02/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class FriendsPhotosController: UICollectionViewController {
    
    var photosNames: [String]!
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    fileprivate func setupColectionViewItemSize() {
        if collectionViewFlowLayout == nil {
            let cellsPerRow: CGFloat = 3
            let interitemSpacing: CGFloat = 5
            let lineSpacing:CGFloat = 5
            
            let width = (collectionView.frame.width - interitemSpacing * (cellsPerRow - 1)) / 3
            let height = width
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interitemSpacing
            
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
            
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupColectionViewItemSize()
    }
    
    // MARK: TableViewDataSource methods
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotoCell", for: indexPath) as! FriendPhotoCell
        
        let photoName = photosNames[indexPath.row]
        cell.photoImage.image = UIImage(named: photoName)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosNames.count
    }
    
    // MARK: CollectionViewDelegate methods
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPhoto" {
            let destinationVC = segue.destination as! ViewPhotoController
            
            
            guard collectionView.indexPathsForSelectedItems?.count == 1 else { return }
            let selectedRow = collectionView.indexPathsForSelectedItems![0].row
            
            destinationVC.selectedImageId = selectedRow
            destinationVC.userPhotosNames = photosNames
        }
    }
}
