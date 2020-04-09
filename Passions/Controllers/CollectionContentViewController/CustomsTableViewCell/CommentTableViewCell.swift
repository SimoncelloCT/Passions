//
//  CommentTableViewCell.swift
//  Passions
//
//  Created by Simone Scionti on 08/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    private var commentData : Comment!
    
    @IBOutlet weak var ownerProfileNameLabel: UILabel!
    @IBOutlet weak var ownerProfileImage: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        setupLayout()
        
    }
    
    private func setupLayout(){
        self.ownerProfileImage.contentMode = .scaleAspectFill
        self.ownerProfileNameLabel.textColor = UIColor.darkGray
    }
    
    private func setCornerProfileImageCornerRadius(){
        self.ownerProfileImage.layer.cornerRadius = self.ownerProfileImage.frame.size.width/2
        self.ownerProfileImage.clipsToBounds = true
        self.ownerProfileImage.layer.masksToBounds = true
    }
    
    override func draw(_ rect: CGRect) {
         setCornerProfileImageCornerRadius()
    }
    
    public func setCellContent(comment: Comment){
        commentData = comment
        //DispatchQueue.main.async {
            self.showContent()
        //}
    }
    
   
       private func showContent(){
        ownerProfileImage.image = commentData.ownerProfile.profileImage
        ownerProfileNameLabel.text = commentData.ownerProfile.profileUsername
        commentTextView.text =  commentData.message
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
