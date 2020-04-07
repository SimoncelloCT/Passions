//
//  CollectionContentTableViewCell.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit

class CollectionContentTableViewCell: UITableViewCell, SSCVDataSource, SSCVSignalUpdateObserver, UITableCellTargettingSubject {
    
    var targetObserver: UITableCellTargettingObserver!
    var collectionData : Collection!
    @IBOutlet weak var horizontalCollectionView : SSCollectionView!
    @IBOutlet weak var collectionPassionNameLabel: UILabel!
    @IBOutlet weak var secondActionButton: UIButton!
    @IBOutlet weak var firstActionButton: UIButton!
    @IBOutlet weak var contentDescriptionTextView: UITextView!
    @IBOutlet weak var contentTypeLabel: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var ownerProfileNameLabel: UILabel!
    @IBOutlet weak var ownerProfileImage: UIImageView!
    private var canPlayVideo = false
    private var targetIndex : Int!
   
    public func canPlayVideo(setTo flag: Bool){
        canPlayVideo = flag
        if flag{ requestPlayVideoOnCell(atIndex: targetIndex) }
        else{ stopVideoOnCell(atIndex: targetIndex) }
    }
    
    private func requestPlayVideoOnCell(atIndex i: Int){
        let cell = horizontalCollectionView.getCell(forIndex: i)
        if let c = cell as? CollectionContentCollectionViewCell , canPlayVideo{
            c.requestPlayVideo()
        }
    }
    private func stopVideoOnCell(atIndex i: Int){
        let cell = horizontalCollectionView.getCell(forIndex: i)
        if let c = cell as? CollectionContentCollectionViewCell{
            c.stopVideo()
        }
    }
    
    override func awakeFromNib() {
        horizontalCollectionView.setup(cellPeekWidth: 70, cellSpacing: 0, scaleValue: 1.2)
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.signalObserver = self
        setLayout()
     }
    
    private func setLayout(){
        self.selectionStyle = .none
        setProfileImageCornerRadius()
        contentDescriptionTextView.isScrollEnabled = false
        setOwnerProfileNameLabelLayout()
        setButtonsLayout()
    }
    
   
    func alphaChanged(alpha: CGFloat) {
        setCellDataAlpha(alpha: alpha)
    }
    
    private func updateTargetIndex(index i: Int){
        targetIndex = i
    }
    
    func targetIndexChanged(targetIndex: Int ,previousTargetIndex: Int) {
        updateTargetIndex(index: targetIndex)
        setContentExternData(forIndex: targetIndex, animated: true, async: true)
        stopVideoOnCell(atIndex: previousTargetIndex)
        requestPlayVideoOnCell(atIndex: targetIndex)
        if let o = targetObserver{
            o.tableCell(cell: self, targetChanged: targetIndex)
        }
    }
  
    override func prepareForReuse() {
        horizontalCollectionView.resetStatus()
    }
    
    public func setStatusTo(index i: Int){
        updateTargetIndex(index: i)
        horizontalCollectionView.setStatusTo(index: i)
    }
     
    public func setCellContent(collection: Collection, lastTargetCellIndex i: Int?, targetObserver: UITableCellTargettingObserver){
        collectionData = collection
        setCollectionHeaderData()
        if let index = i{
            setStatusTo(index: index)
            if index < self.collectionData.items.count{
                self.setContentExternData(forIndex: index, animated: false, async: false)
            }
            else{
                self.setContentExternDataForEmptyCollection()
            }
        }
        targetObserver = targetObserver
    }
    
    private func setButtonsLayout(){
        firstActionButton.setTitleColor(UIColor.white, for: .normal)
        secondActionButton.setTitleColor(UIColor.white, for: .normal)
        firstActionButton.backgroundColor = UIColor.contentLinkButtonOnBlack
        secondActionButton.backgroundColor = UIColor.contentLinkButtonOnBlack
        firstActionButton.clipsToBounds = true
        secondActionButton.clipsToBounds = true
        firstActionButton.layer.cornerRadius = 15
        secondActionButton.layer.cornerRadius = 15
    }
       
    
    private func setContentExternDataForEmptyCollection(){
        print("empty collection")
    }
    
    private func setPassionLabelBackground(backgroundColor: UIColor ){
        self.collectionPassionNameLabel.layer.cornerRadius = 15
        self.collectionPassionNameLabel.clipsToBounds = true
        self.collectionPassionNameLabel.backgroundColor = backgroundColor
    }
    
    private func getFormattedTextForPassionNameLabel(text: String)->String{
        return text+"             "
    }
    
    private func requestDrawTableAnimation(){
        if let tableView = self.superview as? UITableView{
            DispatchQueue.main.async {
               tableView.beginUpdates()
               tableView.endUpdates()
            }
        }
    }
    
    private func setCollectionHeaderData(){
        self.collectionName.text = collectionData.collectionName
        self.ownerProfileNameLabel.text = collectionData.collectionOwner.profileUsername
        self.collectionPassionNameLabel.text = getFormattedTextForPassionNameLabel(text: collectionData.passion.passionName)
        self.setPassionLabelBackground(backgroundColor: collectionData.passion.passionColor)
        self.ownerProfileImage.image = collectionData.collectionOwner.profileImage
        self.ownerProfileImage.contentMode = .scaleAspectFill
    }
    
    private func setOwnerProfileNameLabelLayout(){
        self.ownerProfileNameLabel.textColor = UIColor.usernameOnBlack
    }
    
    private func hideButtons(){
        firstActionButton.isHidden = true
        secondActionButton.isHidden = true
    }
    private func showButtons(){
        firstActionButton.isHidden = false
        secondActionButton.isHidden = false
    }
    
    private func setContentExternData(forIndex index: Int, animated flag: Bool){
        let collectionItem = collectionData.items[index]
        self.contentDescriptionTextView.text = collectionItem.description
        self.contentTypeLabel.text = collectionItem.getContentTypeName()
        self.contentTypeLabel.textColor = UIColor.contentTypeNameOnBlack
        if let _ = collectionItem as? SuggestionObject{ showButtons() }
        else{ hideButtons() }
        if flag{ requestDrawTableAnimation() }
    }
    
    private func setContentExternData(forIndex index: Int, animated flag: Bool, async: Bool){
        if async { DispatchQueue.main.async { self.setContentExternData(forIndex: index, animated: flag) } }
        else { setContentExternData(forIndex: index, animated: flag) }
    }
    
    func SSCV(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.items.count
    }
    
    func SSCV(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionContentCollectionViewCell", for: indexPath) as! CollectionContentCollectionViewCell
        let collectionItem = collectionData.items[indexPath.row]
        if let videoItem = collectionItem as? VideoObject{
            cell.setCellContent(video: videoItem.videoURL)
        }
        else {
            cell.setCellContent(image: collectionItem.collectionCoverImage)
        }
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.items.count
     }
     
    private func setProfileImageCornerRadius(){
        ownerProfileImage.clipsToBounds = true
        ownerProfileImage.layer.cornerRadius = ownerProfileImage.frame.size.width/2
    }
    
    private func setCellDataAlpha(alpha: CGFloat){
        contentDescriptionTextView.alpha = alpha
        contentTypeLabel.alpha = alpha
        firstActionButton.alpha = alpha
        secondActionButton.alpha = alpha
    }
}
