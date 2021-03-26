
import Photos

/*매직넘버를 구현하였습니다.*/
private var WIDTH_SIZE = 100
private var HEIGHT_SIZE = 100

class MyPHAseet: PHAsset {

    /*private 변수를 읽는거나 변경할 수 있도록.*/
    private(set) var photoAssets : PHFetchResult<PHAsset>?
    private(set) var cellSize = CGSize(width: WIDTH_SIZE, height: HEIGHT_SIZE)
    private(set) var cellCount: Int!
    
    func configurePhotoAssets() {
        let smartAlbumCollection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: .none)
        let allContents = smartAlbumCollection.firstObject ?? PHAssetCollection()
        photoAssets = PHAsset.fetchAssets(in: allContents, options: .none)
    }
    
    func updateCellCount() { //setCellCount
        cellCount = photoAssets?.count ?? 0
    }
    
    //ViewController에서 사용하기 위해 추가한 함수    
    func updatetPhtoAssets(updatedPhotoAssets : PHFetchResult<PHAsset>) {
        self.photoAssets = updatedPhotoAssets
    }
    
}
