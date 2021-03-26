//
//  ImageDownloader.swift
//  PhotoApps
//
//  Created by Song on 2021/03/24.
//

import Foundation
import UIKit

///역할: 이미지를 불러오는 task를 진행하고, 캐싱된 이미지 및 진행한 task를 저장한다.
class ImageDownloader {

    private var cachedImages: [URL: UIImage]
    private var imagesDownloadTasks: [URL: URLSessionDataTask]
    private let imageDownloadQueue: DispatchQueue
    
    init() {
        cachedImages = [:]
        imagesDownloadTasks = [:]
        imageDownloadQueue = DispatchQueue.init(label: "imageDownload")
    }

    func downloadImage(imageURL: URL,
                       completionHandler: @escaping (UIImage) -> Void,
                       placeholderImage: UIImage) {
        
        guard getDataTaskFrom(url: imageURL) == nil else { return }
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            
            guard error == nil else {
                completionHandler(placeholderImage)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                self.cachedImages[imageURL] = image
                completionHandler(image)
            } else {
                self.cachedImages[imageURL] = placeholderImage
                completionHandler(placeholderImage)
            }
        }

        imagesDownloadTasks[imageURL] = task
        
        imageDownloadQueue.async {
            task.resume()
        }
    }

    func getCachedImageFrom(url: URL) -> UIImage? {
        return cachedImages[url]
    }

    func getDataTaskFrom(url: URL) -> URLSessionTask? {
        return imagesDownloadTasks[url]
    }
}
