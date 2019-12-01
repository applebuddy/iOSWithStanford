//
//  DemoURLs.swift
//  Caccini
//
//  Created by Kim Taeseon on 2018. 6. 7..
//  Copyright © 2018년 connect.foundation.sr9872. All rights reserved.
//

import Foundation

struct DemoURLs {
    static let stanford = URL(string: "https://upload.wikimedia.org/wikipedia/commons/5/55/Stanford_Oval_September_2013_panorama.jpg")

    static var NASA: [String: URL] = {
        let NASAURLStrings = [
            "Cassini": "https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
            "Earth": "https://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
            "Saturn": "https://www.nasa.gov/sites/default/files/saturn_collage.jpg",
        ]
        var urls = [String: URL]()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
