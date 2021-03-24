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
    
    init() {
        cachedImages = [:]
        imagesDownloadTasks = [:]
    }
    
    func downloadImage(imageURL: URL,
                       completionHandler: @escaping (UIImage?, Bool) -> Void) { //Bool은 성공, 실패의 의미
        
        //image가 이미 캐싱되어 있다면 해당 이미지와 함께 리턴
        if let image = getCachedImageFrom(url: imageURL) {
            completionHandler(image, true)
        } else {
            //task가 이미 생성(진행된 적이 있다면)되어 있다면 리턴
            guard getDataTaskFrom(url: imageURL) == nil else { return }
            
            //iamgeURL에 대한 task 설정
            let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                
                //이미지를 가져올 수 없다면 nil과 함께 리턴
                guard data != nil, error == nil else {
                    DispatchQueue.main.async {
                        completionHandler(nil, false)
                    }
                    return
                }

                let image = UIImage(data: data!)
                self.cachedImages[imageURL] = image
                
                //성공한 경우 이미지와 함께 리턴
                DispatchQueue.main.async {
                    completionHandler(image, true)
                }
            }
            
            //만든 task를 task 목록에 추가
            imagesDownloadTasks[imageURL] = task
            
            //task 실행
            task.resume()
        }
    }

    private func getCachedImageFrom(url: URL) -> UIImage? {
        return cachedImages[url]
    }

    private func getDataTaskFrom(url: URL) -> URLSessionTask? {
        return imagesDownloadTasks[url]
    }
}
