//
//  ViewController.swift
//  PhotoApps
//
//  Created by jinseo park on 3/22/21.
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
        
        self.allPhotoAssets = PHAsset.fetchAssets(with: .none)
        self.numberOfItems = self.allPhotoAssets?.count ?? 0
        
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
        
//        newCell.backgroundColor = randomColorCollection[indexPath.row]
        
        if let asset = allPhotoAssets?[numberOfItems - indexPath.row - 1] {
            newCell.photoCellImageView.image = getAssetThumbnail(asset: asset)
        }
        
        return newCell
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize.init(width: cellSizeUnit, height: cellSizeUnit), contentMode: .aspectFit, options: .none) { (result, _ ) in
            if let result = result {
                thumbnail = result
            }
        }
        return thumbnail
    }
}
