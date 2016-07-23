//
//  Photo.swift
//  Workbox
//
//  Created by Chetan Anand on 17/12/15.
//  Copyright © 2015 Incture Technologies. All rights reserved.
//

import Foundation
import UIKit

struct Photo {
    
    var photoURL : String?
    var thumbnail : UIImage?
    var caption : String?
    
    init(urlString: String?, image: UIImage?, captionString : String?){
        photoURL = urlString
        thumbnail = image
        caption  = captionString
    }

}

