//
//  UIImage+Downloader.swift
//  
//
//  Created by Isaac Ballas on 2019-12-03.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url,completionHandler: { [weak self] url, response, error in
                                                    if error == nil, let url = url,
                                                        let data = try? Data(contentsOf: url),
                                                        let image = UIImage(data: data) {
                                                      
                                                        DispatchQueue.main.async {
                                                            if let weakSelf = self {
                                                                weakSelf.image = image
                                                            }
                                                        }
                                                    }
        })
        downloadTask.resume()
        return downloadTask
    }
}

/*
 # HOW TO USE THIS #
 - Add this extension to a project.
 - Add the instance `var downloadTask: URLSessionDownloadTask?` to hold a reference to the image downloader.
 - Go to where you set the image, and add `downloadTask = UIImageView.loadImage(url: imageURL)`
 
 [weak self] is used here to break a memory leak in the case that UIImageView has been deallocated.
 */
