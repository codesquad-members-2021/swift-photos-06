//
//  ImageManager.swift
//  PhotoApps
//
//  Created by Song on 2021/03/24.
//

import Foundation
import UIKit

///역할: ImageDownloader와 ImageInfoStorage 객체를 소유하고, 해당 객체들을 통해 indexPath에 필요한 이미지를 생성하여 리턴
class ImageManager {
    
    private let downloader: ImageDownloader
    private let infoStorage: ImageInfoStorage
    private let imageURLs: [URL]
    
    init(jsonTitle: String) {
        self.downloader = ImageDownloader()
        self.infoStorage = ImageInfoStorage(jsonTitle: jsonTitle)
        self.imageURLs = infoStorage.imageURLs()
    }
    
    func imageCounts() -> Int {
        return imageURLs.count
    }
    
    func imageForIndex(_ index: Int) -> UIImage {
        var imageLoaded = UIImage()
        downloader.downloadImage(imageURL: imageURLs[index],
                                 completionHandler: { (image, isSuccess) in
                                    imageLoaded = isSuccess ? image! : UIImage()
                                 })
        return imageLoaded
    }
}
