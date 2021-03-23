//
//  ViewController.swift
//  PhotoApps
//
//  Created by lollo, jackson on 3/22/21.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
        
    private var numberOfItems = 40
    private let cellSizeUnit: CGFloat = 100
    private var randomColorCollection = [UIColor]()
    private var allPhotoAssets : PHFetchResult<PHAsset>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomColorCollection = generateRandomColors(count: numberOfItems)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let targetAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: .none)
        
        let album = targetAlbums.firstObject ?? PHAssetCollection()

        self.allPhotoAssets = PHAsset.fetchAssets(in: album, options: .none)
        self.numberOfItems = self.allPhotoAssets?.count ?? 0
        
        registerPhotoLibrary()
                
        self.collectionView.reloadData()
        
    }

    private func generateRandomColors(count: Int) -> [UIColor] {
        var colorCollection = [UIColor]()
        
        for _ in 0..<count {
            let newColor = UIColor.init(red: CGFloat(drand48()),
                                        green: CGFloat(drand48()),
                                        blue: CGFloat(drand48()),
                                        alpha: 1)
            colorCollection.append(newColor)
        }
        return colorCollection
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSizeUnit, height: cellSizeUnit)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! MyCustomViewCell
        
        if let asset = allPhotoAssets?[numberOfItems - indexPath.row - 1] {
            newCell.photoCellImageView.image = getAssetThumbnail(asset: asset)
        }
        
        return newCell
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager =  PHCachingImageManager() //PHImageManager()
        
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        option.resizeMode = .exact
        
        var thumbnail = UIImage()
        let targetSize = CGSize(width: cellSizeUnit, height: cellSizeUnit)
                
        manager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: option) { (result, _) in
            if let result = result {
                thumbnail = result
            }
        }
        return thumbnail
    }
}


extension ViewController : PHPhotoLibraryChangeObserver {
    
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let asset = allPhotoAssets, let changes = changeInstance.changeDetails(for: asset) else { return }
        
        self.allPhotoAssets = changes.fetchResultAfterChanges
        self.numberOfItems = self.allPhotoAssets?.count ?? 0
        
        OperationQueue.main.addOperation {
            self.collectionView.reloadData()
        }
    }
    
    func registerPhotoLibrary() {
        PHPhotoLibrary.shared().register(self)
    }
    
}
