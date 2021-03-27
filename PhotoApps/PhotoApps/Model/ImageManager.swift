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
    private let backgroundDownloadQueue: DispatchQueue
    private let cellInitTimeDownloadQueue: DispatchQueue
    
    init(jsonTitle: String) {
        self.downloader = ImageDownloader()
        self.infoStorage = ImageInfoStorage(jsonTitle: jsonTitle)
        self.imageURLs = infoStorage.imageURLs()
        self.backgroundDownloadQueue = DispatchQueue(label: "background",
                                                        qos: .userInitiated,
                                                        attributes: .concurrent,
                                                        autoreleaseFrequency: .workItem,
                                                        target: nil)
        self.cellInitTimeDownloadQueue = DispatchQueue(label: "cellInitTime",
                                                       qos: .userInitiated,
                                                       attributes: .concurrent,
                                                       autoreleaseFrequency: .workItem,
                                                       target: nil)
    }
    
    func startDownloadingAtBackground() {
        imageURLs.forEach { (url) in
            backgroundDownloadQueue.sync {
                self.downloader.downloadImage(inQueue: self.backgroundDownloadQueue,
                                              imageURL: url, completionHandler: { (_) in },
                                              placeholderImage: UIImage())
            }
        }
    }
    
    enum NotiKeys {
        static let imageDownloadDone = Notification.Name("imageDownloadDone")
    }
    
    func imageForIndex(_ index: Int) -> UIImage {
        if let image = downloader.getCachedImageFrom(url: imageURLs[index]) { return image }

        var imageLoaded = UIImage()
        downloader.downloadImage(inQueue: self.cellInitTimeDownloadQueue,
                                 imageURL: imageURLs[index],
                                 completionHandler: { (image) in
                                    imageLoaded = image
                                 },placeholderImage: UIImage())
        
        let info = ["index": index]
        NotificationCenter.default.post(name: NotiKeys.imageDownloadDone, object: self, userInfo: info)

        return imageLoaded
    }
    
    func imageCounts() -> Int {
        return imageURLs.count
    }
}
