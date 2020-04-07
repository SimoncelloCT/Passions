//
//  CollectionContentCollectionViewCell.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit

class CollectionContentCollectionViewCell: UICollectionViewCell {
    var image : UIImage!
    var video : String!
    var mediaView : UIView!
    private var requestedPlay = false //fix the first play cell
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadius()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let _ = image{
            setCellForImageContent()
        }
        else if let _ = video{
            setCellForVideoContent()
        }
    }
    
    private func setCellForImageContent(){
        mediaView = UIImageView()
        self.contentView.addSubview(mediaView)
        mediaView.frame = self.contentView.frame
        let imageView = mediaView as! UIImageView
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(mediaView)
        mediaView.frame = self.contentView.frame
        mediaView.backgroundColor = UIColor.lightGray
    }
    
    public func hasVideoContent() -> Bool{
        return video != nil
    }
    
    public func requestPlayVideo(){
        requestedPlay = true
        if let videoView  = mediaView as? UIVideoView{
            videoView.play()
            requestedPlay = false
        }
    }
    
    public func stopVideo(){
        if let videoView  = mediaView as? UIVideoView{
            videoView.stop()
        }
    }
    
    private func setCellForVideoContent(){
        self.mediaView = UIVideoView.init()
        self.contentView.addSubview(self.mediaView)
        mediaView.backgroundColor = UIColor.lightGray
        DispatchQueue.main.async {
           
            let videoView = self.mediaView as! UIVideoView
                   videoView.frame = self.contentView.frame
            videoView.configure(url: self.video)
                   videoView.isLoop = true
            if self.requestedPlay{
                       videoView.play()
                   }
            self.contentView.addSubview(self.mediaView)
            self.mediaView.frame = self.contentView.frame
        }
       
    }
    
    public func setCellContent(image: UIImage! = nil, video: String! = nil){
        self.image = image
        self.video = video
        setNeedsDisplay()
    }
    private func setCornerRadius(radius : CGFloat = 10.0){
        self.clipsToBounds = true
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }
}
