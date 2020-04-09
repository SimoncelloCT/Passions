//
//  SSTextView.swift
//  Passions
//
//  Created by Simone Scionti on 09/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit

class SSTextView: UIView , UITextViewDelegate {
    
    //need a constraint to bottom in storyboard
    private var defaultHeight : CGFloat = 50
    private var heightConstraint : NSLayoutConstraint!
    private var textView = UITextView()
    private var confirmButton = UIButton()
    private var observer : SSTextViewObserver!
    private var placeholder : String!
    private var textColor: UIColor!
    private var placeholderColor: UIColor!
    
    public func setup(withPlaceholder placeholder: String , withTextColor textColor: UIColor = .darkGray ,withPlaceholderTextColor placeholderColor: UIColor = .lightGray, withObserver observer: SSTextViewObserver ){
        self.textColor = textColor
        self.observer = observer
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
        heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: defaultHeight)
        NSLayoutConstraint.activate([heightConstraint])
        self.textView.isScrollEnabled = false
        self.textView.textColor = textColor
        self.textView.layer.cornerRadius = self.textView.frame.size.height/2
        self.textView.clipsToBounds = true
        self.textView.textContainerInset = UIEdgeInsets(top: 11, left: 5, bottom: 0, right: 40)
        self.textView.text = placeholder
        self.textView.delegate = self
        self.layer.zPosition = 10.0
        setupKeyboardListeners()
        setupSubViewFrames()
    }
    
    private func setupConfirmButtonListener(){
        
    }
    
    @objc func confirmButtonClicked(){
        observer.confirmButtonClicked(currentText: getCurrentText())
    }
    
    private func setupSubViewFrames(){
        setupTextViewFrame()
        setupConfirmButtonFrame()
    }
    
    private func setupConfirmButtonFrame(){
        let CBHeightConstraint = NSLayoutConstraint(item: confirmButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30)
        let CBWidthConstraint = NSLayoutConstraint(item: confirmButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30)
        let CBTrailing = NSLayoutConstraint(item: confirmButton, attribute: .trailing, relatedBy: .equal, toItem: textView, attribute: .trailing, multiplier: 1.0, constant: 0)
        let CBBottom = NSLayoutConstraint(item: confirmButton, attribute: .bottom, relatedBy: .equal, toItem: textView, attribute: .bottom, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([CBHeightConstraint, CBWidthConstraint, CBTrailing, CBBottom])
    }
    
    private func setupTextViewFrame(){
        let textViewHeightConstraint = NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.8, constant: 0)
        let textViewWidthConstraint = NSLayoutConstraint(item: textView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.8, constant: 0)
        let textViewCenterX = NSLayoutConstraint(item: textView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        let textViewCenterY = NSLayoutConstraint(item: textView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([textViewHeightConstraint, textViewWidthConstraint, textViewCenterX, textViewCenterY])
    }
    
    public func getCurrentText()->String{
        return textView.text
    }
    
    func textViewDidChange(_ textView: UITextView) {
        observer.textDidChange(newText: textView.text)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.isScrollEnabled = true
        if textView.text == placeholder{
            textView.text = ""
            textView.textColor = textColor
        }
        observer.startEditing()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.isScrollEnabled = false
        if textView.text == ""{
            textView.text = placeholder
            textView.textColor = placeholderColor
            
        }
        observer.endEditing()
    }
    
    private func setupKeyboardListeners(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func animateHeightChange(withHeight height: CGFloat){
        self.heightConstraint.constant = height
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
     @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let bottomPadding = window!.safeAreaInsets.bottom
        let textViewContainerTY = -1*(keyboardFrame.height - bottomPadding - 49)
        self.transform = CGAffineTransform.init(translationX: 0, y: textViewContainerTY)
        let newTextViewHeight = keyboardFrame.origin.y - self.frame.origin.y
         animateHeightChange(withHeight: newTextViewHeight)
     }
     
     @objc func keyboardWillHide(notification: NSNotification) {
         guard let _ = notification.userInfo else {return}
         self.transform = CGAffineTransform.identity
         animateHeightChange(withHeight: 50)
     }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
