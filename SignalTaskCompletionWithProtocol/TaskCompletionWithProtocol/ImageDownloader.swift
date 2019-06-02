//
//  Image.swift
//  GCDExample
//
//  Created by Tu Lam Lam on 2/6/19.
//  Copyright © 2019 Tu Lam Lam. All rights reserved.
//

import Foundation
import UIKit
protocol DownloadDelegate {
    func didDownload(images: [UIImage])
}

class ImageDownloader {
    var images = [UIImage]()
    var delegate: DownloadDelegate
    let session = URLSession(configuration: .default)
    
    init(delegate: DownloadDelegate) {
        self.delegate = delegate
    }
    
    func downloadImageWithURL(_ url: URL) {
        let task = session.dataTask(with: url) {data, response, error in
            if let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.images.append(UIImage(data: data)!)
            } else if let error = error {
                print(error)
            }
            self.delegate.didDownload(images: self.images)
        }
        
        task.resume()
    }
}
