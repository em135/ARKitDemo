//
//  ImageMapper.swift
//  ARKitDemo
//
//  Created by Emil Nielsen on 07/11/2019.
//  Copyright © 2019 Emil Nielsen. All rights reserved.
//

import Foundation

class ImageMapper {
    
    var images = [String: Image]()
    
    init() {
        images["TheScream"] = Image(name: "The Scream", author: "Edvard Munch", year: 1893)
        images["MonaLisa"] = Image(name: "Mona Lisa", author: "Leonardo da Vinci", year: 1503)
        images["TheStarryNight"] = Image(name: "The Starry Night", author: "Vincent van Gogh", year: 1889)
    }
}
