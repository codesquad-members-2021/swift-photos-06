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

    private let phAsset = MyPHAseet()
    private let cellID = "photoCell"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        
        phAsset.configurePhotoAssets()
        phAsset.updateCellCount()
        
        registerPhotoLibrary()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.reloadData()
    }
    
    @IBAction func addBtnTouched(_ sender: Any) {
        /*코드로 네비게이션 컨트롤러를 이용하여 DoodleViewController로 Modal하기.*/
        let toDoodleVC = UINavigationController(rootViewController: DoodleViewController())
        toDoodleVC.modalPresentationStyle = .fullScreen
        present(toDoodleVC, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return phAsset.cellCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PhotoViewCell
        
        let photoIdxToShow = phAsset.cellCount - indexPath.row - 1 //최신 항목부터 표시

        if let asset = phAsset.photoAssets?[photoIdxToShow] {
            newCell.photoCellImageView.image = getAssetThumbnail(asset: asset)
            let type = asset.mediaSubtypes
            if type == .photoLive {
                
                let livePhotoImg = UIImage(systemName: "livephoto")
//                livePhotoImg?.withTintColor(.white)
                
                let imageView = UIImageView(image: livePhotoImg)
                newCell.photoCellImageView.addSubview(imageView)
            }
        }
        
        return newCell
    }
    
    private func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager =  PHCachingImageManager()
        
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        option.resizeMode = .exact
        
        var thumbnail = UIImage()
                
        manager.requestImage(for: asset, targetSize: phAsset.cellSize, contentMode: .aspectFill, options: option) { (result, _) in
            if let result = result {
                thumbnail = result
            }
        }
        return thumbnail
    }
}

extension ViewController : PHPhotoLibraryChangeObserver {
    
    func registerPhotoLibrary() {
        PHPhotoLibrary.shared().register(self)
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let asset = phAsset.photoAssets,
              let changes = changeInstance.changeDetails(for: asset) else { return }
        
        OperationQueue.main.addOperation {
        
            self.phAsset.updatetPhtoAssets(updatedPhotoAssets: changes.fetchResultAfterChanges)
            self.phAsset.updateCellCount()
        
            guard changes.hasIncrementalChanges else { //아주 큰 변화가 있을 시엔 전체를 reload해야 함
                self.collectionView.reloadData()
                return
            }
            
            self.collectionView.performBatchUpdates({
                
                if let removed = changes.removedIndexes, removed.count > 0 {
                    self.collectionView.deleteItems(at: removed.map { IndexPath(item: $0, section: 0) })
                }
                
                if let inserted = changes.insertedIndexes, inserted.count > 0 {
                    self.collectionView.insertItems(at: inserted.map { IndexPath(item: $0, section: 0)})
                }
                
                if let changed = changes.changedIndexes, changed.count > 0 {
                    self.collectionView.reloadItems(at: changed.map { IndexPath(item: $0, section: 0) })
                }
                
                changes.enumerateMoves { (fromIdx, toIdx) in
                    self.collectionView.moveItem(at: IndexPath(item: fromIdx, section: 0),
                                                 to: IndexPath(item: toIdx, section: 0))
                }
            })
        }
    }
}
