//
//  NewsCollectionViewCell.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    var imageView : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadius()
        imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFill
    }
    
    override func draw(_ rect: CGRect) {
        imageView.frame = self.frame
        self.addSubview(imageView)
    }
    
    public func setCellContent(image: UIImage){
        imageView.image = image
    }
    
    private func setCornerRadius(radius : CGFloat = 10.0){
        self.clipsToBounds = true
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }
  
    
}
