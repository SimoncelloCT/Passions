//
//  CollectionCollectionViewCell.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit

class CollectionCollectionViewCell: UICollectionViewCell {
    
    var collectionData : Collection!
    var leftUpImageView : UIImageView!
    var leftBottomImageView: UIImageView!
    var rightImageView: UIImageView!
    
    var margin : CGFloat = 7.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.white
        leftUpImageView = UIImageView.init()
        leftBottomImageView = UIImageView.init()
        rightImageView = UIImageView.init()
        setCornerRadius()
    }
    override func draw(_ rect: CGRect) {
        setupCollectionCellLayout()
    }
    
    public func setCollectionData(collection: Collection){
        collectionData = collection
        setupCellData()
    }
    private func setupCellData(){
        leftUpImageView.image = collectionData.leftUpImage
        leftBottomImageView.image = collectionData.leftBottomImage
        rightImageView.image = collectionData.rightImage
    }
    
    private func setupCollectionCellLayout(){
        let contentViewLeftCenter = CGPoint(x: contentView.center.x/2, y: contentView.center.y)
        let contentViewRightCenter = CGPoint(x: contentView.center.x * 1.5, y: contentView.center.y)
        setupLeftUpImageLayout(contentViewLeftCenter: contentViewLeftCenter)
        setupLeftBottomImageLayout(contentViewLeftCenter: contentViewLeftCenter)
        setupRightImageLayout(contentViewRightCenter: contentViewRightCenter)
    }
    
    private func setupLeftUpImageLayout(contentViewLeftCenter: CGPoint){
        let leftUpImageCenter = CGPoint(x: contentViewLeftCenter.x + (margin/4), y: contentViewLeftCenter.y/2 + (margin/4))
        let contentViewWidth = contentView.frame.size.width
        let contentViewHeight = contentView.frame.size.height
        leftUpImageView.frame = CGRect(x: 0, y: 0, width: contentViewWidth/2 - margin, height: contentViewHeight/2 - margin)
        leftUpImageView.center = leftUpImageCenter
        leftUpImageView.backgroundColor = UIColor.blue
        leftUpImageView.clipsToBounds = true
        leftUpImageView.layer.cornerRadius = 10.0
        leftUpImageView.contentMode = .scaleAspectFill
        
        self.contentView.addSubview(leftUpImageView)
    }
    private func setupLeftBottomImageLayout(contentViewLeftCenter: CGPoint){
           let leftBottomImageCenter = CGPoint(x: contentViewLeftCenter.x + (margin/4), y: contentViewLeftCenter.y*1.5 - (margin/4))
           let contentViewWidth = contentView.frame.size.width
           let contentViewHeight = contentView.frame.size.height
            leftBottomImageView.frame = CGRect(x: 0, y: 0, width: contentViewWidth/2 - margin, height: contentViewHeight/2 - margin)
           leftBottomImageView.center = leftBottomImageCenter
           leftBottomImageView.backgroundColor = UIColor.red
            leftBottomImageView.clipsToBounds = true
            leftBottomImageView.layer.cornerRadius = 10.0
        leftBottomImageView.contentMode = .scaleAspectFill
           self.contentView.addSubview(leftBottomImageView)
       }
    
    private func setupRightImageLayout(contentViewRightCenter: CGPoint){
        let rightImageCenter = CGPoint(x: contentViewRightCenter.x - (margin/8), y: contentViewRightCenter.y)
            let contentViewWidth = contentView.frame.size.width
            let contentViewHeight = contentView.frame.size.height
            rightImageView.frame = CGRect(x: 0, y: 0, width: contentViewWidth/2 - margin - (margin/4), height: contentViewHeight - margin - (margin/2))
            rightImageView.center = rightImageCenter
            rightImageView.backgroundColor = UIColor.yellow
            rightImageView.clipsToBounds = true
            rightImageView.layer.cornerRadius = 10.0
        rightImageView.contentMode = .scaleAspectFill
            self.contentView.addSubview(rightImageView)
    }
       
       private func setCornerRadius(radius : CGFloat = 10.0){
           self.clipsToBounds = true
           self.layer.cornerRadius = 10.0
           self.layer.masksToBounds = true
       }
}
