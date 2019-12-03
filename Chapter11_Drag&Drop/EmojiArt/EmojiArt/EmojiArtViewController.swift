//
//  EmojiArtViewController.swift
//  EmojiArt
//
//  Created by Kim Taeseon on 2018. 6. 10..
//  Copyright © 2018년 connect.foundation.sr9872. All rights reserved.
//

import UIKit

class EmojiArtViewController: UIViewController, UIDropInteractionDelegate {
//    [C1-3] View들을 각각 연결해 줍니다.
    @IBOutlet var dropZone: UIView! {
        didSet {
            dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }

//    [C1-4] 드래그 & 드랍과 관련된 코드를 구현해 줍니다.

    func dropInteraction(_: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self)
    }

    func dropInteraction(_: UIDropInteraction, sessionDidUpdate _: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }

    var imageFetcher: ImageFetcher!

    func dropInteraction(_: UIDropInteraction, performDrop session: UIDropSession) {
        imageFetcher = ImageFetcher { _, image in
            DispatchQueue.main.async {
                self.emojiArtView.backgroundImage = image
            }
        }

        session.loadObjects(ofClass: NSURL.self) { nsurls in
            if let url = nsurls.first as? URL {
                self.imageFetcher.fetch(url)
            }
        }
        session.loadObjects(ofClass: UIImage.self) { images in
            if let image = images.first as? UIImage {
                self.imageFetcher.backup = image
            }
        }
    }

    @IBOutlet var emojiArtView: EmojiArtView!
}
