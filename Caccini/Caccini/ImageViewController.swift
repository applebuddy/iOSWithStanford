//
//  ImageViewController.swift
//  Caccini
//
//  Created by Kim Taeseon on 2018. 6. 7..
//  Copyright © 2018년 connect.foundation.sr9872. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
//    [C2-3]
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }

//    [C2-4]
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }

//    [C3-3]
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }

//    [C3-2]
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

//    [C2-2]
//    @IBOutlet weak var imageView: UIImageView!
//    [C3-1]
    var imageView = UIImageView()
//    [C2-3]
    private func fetchImage() {
//        [C2-5]
        if let url = imageURL {
            let urlContents = try? Data(contentsOf: url)
            if let myImage = urlContents {
                image = UIImage(data: myImage)
            }
        }
    }

//    [C2-6]
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = DemoURLs.stanford
        }
    }
}
