//
//  ImageViewController.swift
//  Caccini
//
//  Created by Kim Taeseon on 2018. 6. 7..
//  Copyright © 2018년 connect.foundation.sr9872. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }

    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
//            [C3-2]
            spinner?.stopAnimating()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }

//    [C3-1]
    @IBOutlet var spinner: UIActivityIndicatorView!

    @IBOutlet var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1 / 25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }

    func viewForZooming(in _: UIScrollView) -> UIView? {
        return imageView
    }

    var imageView = UIImageView()

    private func fetchImage() {
        if let url = imageURL {
//            [C3-1]
            spinner?.startAnimating()
//            [C2-2]
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
//                [C2-3]
                DispatchQueue.main.async {
//                    [C2-4]
                    if let imageData = urlContents, url == self?.imageURL {
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        if imageURL == nil {
//            imageURL = DemoURLs.stanford
//        }
    }
}
