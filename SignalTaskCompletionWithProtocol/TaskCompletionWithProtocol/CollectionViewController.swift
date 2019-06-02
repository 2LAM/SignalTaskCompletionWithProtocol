//
//  CollectionViewController.swift
//  GCDExample
//
//  Created by Tu Lam Lam on 2/6/19.
//  Copyright © 2019 Tu Lam Lam. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UIViewController, DownloadDelegate {
    func didDownload(images: [UIImage]) {
        self.images = images
        DispatchQueue.main.async {
             self.collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dispatchGroup = DispatchGroup()
    var images = [UIImage]()
    
    let imageURL1 = "https://images.unsplash.com/photo-1513343987712-5da15ea2a9bb?ixlib=rb-1.2.1&auto=format&fit=crop&w=1567&q=80"
    let imageURL2 = "https://images.unsplash.com/photo-1470294402047-fc1b5f39bd99?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1508&q=80"
    let imageURL3 = "https://images.unsplash.com/photo-1505642257289-9f2d7dd73641?ixlib=rb-1.2.1&auto=format&fit=crop&w=1588&q=80"
    let imageURL4 = "https://images.unsplash.com/photo-1444841461048-410031d44215?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1510&q=80"
    let imageURL5 = "https://images.unsplash.com/photo-1526958977630-bc61b30a2009?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80"
    var imageURLs = [String]()
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let imageDownloader = ImageDownloader(delegate: self)
        imageURLs = [imageURL1, imageURL2, imageURL3, imageURL4, imageURL5]
        
        for imageURL in self.imageURLs {
            imageDownloader.downloadImageWithURL(URL.init(string: imageURL)!)
        }
        
        super.viewDidLoad()
    }
}




extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = .black
        cell.imageView.image = images[indexPath.row]
        return cell
    }
}
