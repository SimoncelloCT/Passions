//
//  ContentMetadataTableViewCell.swift
//  Passions
//
//  Created by Simone Scionti on 08/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit

class ContentMetadataTableViewCell: UITableViewCell {
    private var contentData :ShareObject!
    @IBOutlet weak var secondActionLinkButton: UIButton!
    @IBOutlet weak var firstActionLinkButton: UIButton!
    @IBOutlet weak var contentDescriptionTextView: UITextView!
    @IBOutlet weak var contentTypeNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentDescriptionTextView.isScrollEnabled = false
        self.contentDescriptionTextView.isEditable = false
        self.contentTypeNameLabel.textColor = UIColor.darkGray
        self.selectionStyle = .none
        
    }
    
    public func setCellContent(shareObject: ShareObject){
        contentData = shareObject
        //DispatchQueue.main.async {
            self.showContent()
        //}
        
    }
    
    private func showContent(){
        contentDescriptionTextView.text = contentData.description
        contentTypeNameLabel.text = contentData.getContentTypeName()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
