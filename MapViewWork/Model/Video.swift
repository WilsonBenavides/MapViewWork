//
//  Video.swift
//  MapViewWork
//
//  Created by willix on 24/05/18.
//  Copyright © 2018 willix. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: Date?
    
    var channel: Channel?
}

class Channel: NSObject {
    
    var name: String?
    var profileImageName: String?
}
