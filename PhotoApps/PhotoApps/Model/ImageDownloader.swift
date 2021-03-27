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
    private let dictionaryUpdateQueue: DispatchQueue
    
    init() {
        cachedImages = [:]
        imagesDownloadTasks = [:]
        dictionaryUpdateQueue = DispatchQueue(label: "dictionary",
                                              qos: .userInitiated,
                                              attributes: .concurrent,
                                              autoreleaseFrequency: .workItem,
                                              target: nil)
    }

    func downloadImage(inQueue queue: DispatchQueue,
                       imageURL: URL,
                       completionHandler: @escaping (UIImage) -> Void,
                       placeholderImage: UIImage) {
        
        guard getDataTaskFrom(url: imageURL) == nil else { return }
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            
            guard error == nil else {
                completionHandler(placeholderImage)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                self.dictionaryUpdateQueue.async(flags: .barrier) {
                    self.cachedImages[imageURL] = image
                }
                completionHandler(image)
            } else {
                self.dictionaryUpdateQueue.async(flags: .barrier) {
                    self.cachedImages[imageURL] = placeholderImage
                }
                completionHandler(placeholderImage)
            }
        }
        
        dictionaryUpdateQueue.async(flags: .barrier) {
            self.imagesDownloadTasks[imageURL] = task
        }
        
        queue.async {
            task.resume()
        }
    }

    func getCachedImageFrom(url: URL) -> UIImage? {
        var image: UIImage?
        dictionaryUpdateQueue.sync {
            image = self.cachedImages[url]
        }
        return image
    }

    func getDataTaskFrom(url: URL) -> URLSessionTask? {
        var task: URLSessionTask?
        dictionaryUpdateQueue.sync {
            task = self.imagesDownloadTasks[url]
        }
        return task
    }
}




