//
//  CollectionContentViewController.swift
//  Passions
//
//  Created by Simone Scionti on 07/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit

class CollectionContentViewController: UIViewController, SSCVDataSource, SSCVSignalUpdateObserver, UITableViewDelegate , UITableViewDataSource , CollectionContentGestureRecognizerAnimationObserver , UITextViewDelegate {

    @IBOutlet weak var addCommentContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addCommentContainerView: UIView!
    @IBOutlet weak var addCommentTextView: UITextView!
    @IBOutlet weak var dragPointView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var externContentView: UIView!
    @IBOutlet weak var horizontalCollectionView: SSCollectionView!
    var viewIsOnBottom : Bool = false
    var collectionData: Collection!
    var gestureAnimator  = CollectionContentGestureRecognizer()
    
    var startingTextViewText : String!
    
    var initialTarget : Int! = 0
    var currentTarget : Int! = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        startingTextViewText = "Scrivi un commento.."
        horizontalCollectionView.setup(cellPeekWidth: 130, cellSpacing: 15, scaleValue: 1.3)
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.signalObserver = self
        setupPanGestureRecognizer()
       
        self.view.clipsToBounds = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        
       /* addCommentTextView.isScrollEnabled = false
        addCommentTextView.textColor = UIColor.gray
        addCommentTextView.layer.cornerRadius = addCommentTextView.frame.size.height/2
        addCommentTextView.clipsToBounds = true
        addCommentTextView.textContainerInset = UIEdgeInsets(top: 11, left: 5, bottom: 0, right: 40)
        addCommentTextView.text = startingTextViewText
        addCommentTextView.delegate = self
        addCommentContainerView.layer.zPosition = 10.0
        //addCommentTextView
        //addCommentTextView.sizeToFit()
        */
        
        self.tableView.layer.zPosition = 1.0
        
      //  print("commentsCount: ")
       /* NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        /*NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)*/
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)*/
        
    }

    
    
    /*
    private func animateHeightChange(withHeight height: CGFloat){
        addCommentContainerViewHeightConstraint.constant = height
        UIView.animate(withDuration: 0.3) {
            self.addCommentContainerView.layoutIfNeeded()
        }
    }*/
    
   
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.isScrollEnabled = true
        tableView.isUserInteractionEnabled = false
        horizontalCollectionView.isUserInteractionEnabled = false
        if textView.text == startingTextViewText{
            textView.text = ""
            textView.textColor = UIColor.darkGray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = true
        horizontalCollectionView.isUserInteractionEnabled = true
        
        if textView.text == ""{
            textView.text = startingTextViewText
            textView.textColor = UIColor.lightGray
            
        }
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.addCommentTextView.resignFirstResponder()
    }
    
    /*
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let bottomPadding = window!.safeAreaInsets.bottom
        let textViewContainerTY = -1*(keyboardFrame.height - bottomPadding - 49)
        addCommentContainerView.transform = CGAffineTransform.init(translationX: 0, y: textViewContainerTY)
        let newTextViewHeight = keyboardFrame.origin.y - externContentView.frame.origin.y
        animateHeightChange(withHeight: newTextViewHeight)
    }
    
   
    
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let _ = notification.userInfo else {return}
        self.addCommentContainerView.transform = CGAffineTransform.identity
        animateHeightChange(withHeight: 50)
    }*/
    
    func didMoveToCenter() {
        self.tableView.isScrollEnabled = true
    }
    
    func didMoveToBottom() {
        self.tableView.isScrollEnabled = false
        //self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section  == 1{
            return getSectionHeaderView(withText: "Commenti (" + String(collectionData.items[currentTarget].comments.count) + ")")
        }
        return UIView()
    }
    
    private func getSectionHeaderView(withText text: String)-> UIView{
        let label = getSectionLabel(withText: text)
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
        view.addSubview(label)
        label.center = view.center
        return view
    }
    
    private func getSectionLabel(withText text: String) -> UILabel{
        let sectionTitleLabel = UILabel.init(frame: CGRect(x:0, y: 0, width: self.view.frame.size.width * 0.9, height: 20))
        sectionTitleLabel.text = text
        sectionTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        sectionTitleLabel.textColor = UIColor.darkGray
        return sectionTitleLabel
    }

    override func viewDidAppear(_ animated: Bool) {
        horizontalCollectionView.setStatusTo(index: initialTarget, animated: true)
    }
    
    public func setup(collection: Collection ,withInitialTarget target: Int, withZoomAnimation flag: Bool){
        self.collectionData = collection
        self.initialTarget = target
    }
    
    private func setupPanGestureRecognizer(){
        gestureAnimator.setup(forView: self.view, externContentView:
         self.externContentView, horizontalCollectionView: self.horizontalCollectionView, target: self)
        gestureAnimator.animationObserver = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1 //metadata cell
        }
        //other cells -> comments
        print("ritorno commenti: ", collectionData.items[currentTarget].comments.count)
        return collectionData.items[currentTarget].comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{//metadatacell
            let cell = tableView.dequeueReusableCell(withIdentifier: "contentMetadataTableViewCell") as! ContentMetadataTableViewCell
            cell.setCellContent(shareObject: collectionData.items[currentTarget])
            return cell
        }
        else{ //commentCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentTableViewCell") as! CommentTableViewCell
            cell.setCellContent(comment: collectionData.items[currentTarget].comments[indexPath.row] )
            return cell
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBarLayout()
        setExternContentViewLayout()
    }
    
    
    override func viewDidLayoutSubviews() {
        setExternContentViewLayout()
     
        
    }
    
    private func setExternContentViewLayout(){
        externContentView.clipsToBounds = true
        externContentView.layer.masksToBounds = true
           externContentView.roundCorners(corners: [.topLeft, .topRight], radius: 15.0)
        externContentView.setNeedsDisplay()
    }
    
    private func setNavBarLayout(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.backItem?.backBarButtonItem?.style = .plain
        //= UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
    
    func alphaChanged(alpha: CGFloat) {
        self.tableView.alpha = alpha
        //self.addCommentContainerView.alpha = alpha
    }
    
    func targetIndexChanged(targetIndex: Int, previousTargetIndex: Int) {
        self.currentTarget = targetIndex
       // self.tableView.beginUpdates()
        //if let c = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? ContentMetadataTableViewCell {
          //  c.setCellContent(shareObject: collectionData.items[currentTarget])
        //}
        //self.tableView.endUpdates()
        
        if let previousCell =  horizontalCollectionView.getCell(forIndex: previousTargetIndex) as? CollectionContentCollectionViewCell{
            previousCell.pauseVideo()
        }
        if let newCell = horizontalCollectionView.getCell(forIndex: targetIndex) as? CollectionContentCollectionViewCell{
            newCell.requestPlayVideo()
        }
        tableView.reloadData()
    }
    
    deinit {
         print("deinit Collection content")
    }
    
   

}
