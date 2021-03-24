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

    let phAsset = MyPHAseet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        phAsset.configurePhotoAssets()
        phAsset.updateCellCount()
        
        registerPhotoLibrary()
    }
    
    
    @IBAction func addBtnTouched(_ sender: Any) {
        /*코드로 네비게이션 컨트롤러를 이용하여 DoodleViewController로 Modal하기.*/
        let toDoodleVC = UINavigationController(rootViewController: DoodleViewController())
        present(toDoodleVC, animated: true)
        
    }
    
    
}

/* 위에서 cellSize를 let으로 설정했는데 이 함수를 쓰는 이유를 모르겠다. 질문하기*/

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return phAsset.cellSize
        
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return phAsset.cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoViewCell
        
        let photoIdxToShow = phAsset.cellCount - indexPath.row - 1 //최신 항목부터 표시
        
        if let asset = phAsset.photoAssets?[photoIdxToShow] {
            newCell.photoCellImageView.image = getAssetThumbnail(asset: asset)
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
