//
//  CollectionContentGestureRecognizer.swift
//  Passions
//
//  Created by Simone Scionti on 08/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation
import UIKit


enum Position {
    case center
    case bottom
}

class CollectionContentGestureRecognizer : NSObject , CollectionContentGestureRecognizerAnimationSubject{
    weak var animationObserver: CollectionContentGestureRecognizerAnimationObserver!
    
    private var externContentView: UIView!
    private var horizontalCollectionView: SSCollectionView!
    var currentSSCVScale : CGFloat! = 1
    var currentSSCVTranslationY : CGFloat! = 0
    var currentExternContentViewTranslation : CGFloat! = 0
    var currentPos : Position! = .center
    var baseView : UIView!
    
    
    public func setup(forView view: UIView, externContentView: UIView , horizontalCollectionView: SSCollectionView, target: UIViewController){
        self.externContentView = externContentView
        self.horizontalCollectionView = horizontalCollectionView
        
        let panGestureRecognizer = UIPanGestureRecognizer.init(target: self , action: #selector(dragGestureStart(_ :)))
        view.addGestureRecognizer(panGestureRecognizer)
        baseView = view
        
        
    }
    
    
    @objc private func dragGestureStart(_ gestureRecognizer: UIPanGestureRecognizer){
           guard gestureRecognizer.view != nil else {return}
           let view = externContentView!
           // Get the changes in the X and Y directions relative to
           // the superview's coordinate space.
        let translation = gestureRecognizer.translation(in: view.superview?.superview)
           var newScale = currentSSCVScale + translation.y/150
           var newSSCVTranslationY = ( (150/1.9) * (newScale - currentSSCVScale) ) + currentSSCVTranslationY
               //currentSSCVTranslationY + translation.y/1.9
           var newECVTranslationY = 150 * (newScale - currentSSCVScale) + currentExternContentViewTranslation
           //currentExternContentViewTranslation + translation.y
           
           let defaultRadius = horizontalCollectionView.getDefaultRadius()
        
            if gestureRecognizer.state == .began{
                baseView.endEditing(true)
            }
       
           if gestureRecognizer.state != .cancelled {
               if newScale <= 2.9 && newScale >= 1.0 {
                   horizontalCollectionView.transform = CGAffineTransform.init(translationX: 0.0, y: newSSCVTranslationY).scaledBy(x: newScale , y: newScale)
                   view.transform = CGAffineTransform.init(translationX: 0.0, y: newECVTranslationY)
                   horizontalCollectionView.updateCellsCornerRadius(radius: defaultRadius / newScale)
               }
           }
           
           if gestureRecognizer.state == .ended{
            let velocity = gestureRecognizer.velocity(in: view.superview?.superview)
           
               //check the current image scale to decide to go back or finish the animation
               if velocity.y > 1500  || newScale >= 2.0  {
                   newScale = 2.9
                   newSSCVTranslationY = ( (150/1.9) * (newScale - currentSSCVScale) ) + currentSSCVTranslationY
                   newECVTranslationY = 150 * (newScale - currentSSCVScale) + currentExternContentViewTranslation
                   
                UIView.animate(withDuration: 0.15, animations: {
                        self.horizontalCollectionView.transform = CGAffineTransform.init(translationX: 0.0, y: newSSCVTranslationY).scaledBy(x: newScale , y: newScale)
                        view.transform = CGAffineTransform.init(translationX: 0.0, y: newECVTranslationY)
                        self.horizontalCollectionView.updateCellsCornerRadius(radius: defaultRadius / newScale)
                                           
                    }) { (flag) in
                        if self.currentPos == .center {
                            self.animationObserver.didMoveToBottom()
                            self.currentPos = .bottom
                        }
                }
                
               } else {
                UIView.animate(withDuration: 0.15, animations: {
                        view.transform = .identity
                        self.horizontalCollectionView.transform = .identity
                        }) { (flag) in
                            if self.currentPos == .bottom {
                                self.animationObserver.didMoveToCenter()
                                self.currentPos = .center
                            }
                        }
               }
           
               currentSSCVScale = self.horizontalCollectionView.transform.a
               currentSSCVTranslationY = self.horizontalCollectionView.transform.ty
               currentExternContentViewTranslation = view.transform.ty
           }
       }
    
    public func requestAnimation(toPosition pos: Position, timeInterval t: TimeInterval = 0.3){
        if pos == .bottom && currentPos == .center{
            
        }
        else if pos == .center && currentPos == .bottom{
           
        }
    }
    
    
}
