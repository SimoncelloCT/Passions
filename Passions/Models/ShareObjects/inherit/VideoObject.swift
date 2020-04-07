//
//  VideoObject.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation
import UIKit
class VideoObject : ContentObject {
    var videoURL : String!
    var coverFrame: UIImage!

    init(videoUrl: String!, description : String! = nil, videoFrameImage: UIImage! = nil) {
        if let frame = videoFrameImage{
            coverFrame = frame
        }
        else{
            coverFrame = UIImage()
        }
        super.init(description: description, collectionCoverImage: coverFrame)
        self.videoURL = videoUrl
    }

    override public func getContentTypeName() -> String { //virtual method
        return "Video"
    }
}
