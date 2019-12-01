//
//  CassiniViewController.swift
//  Caccini
//
//  Created by Kim Taeseon on 2018. 6. 9..
//  Copyright © 2018년 connect.foundation.sr9872. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
//    [C2-1]
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if let url = DemoURLs.NASA[identifier] {
                if let imageVC = segue.destination.contents as? ImageViewController {
                    imageVC.imageURL = url
                    imageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }
}

// [C3-4]
extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
