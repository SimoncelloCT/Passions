//
//  HorizontalCollectionView.swift
//  Passions
//
//  Created by Simone Scionti on 05/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class SSHorizontalCollectionView: UIView, UICollectionViewDelegate, UIScrollViewDelegate , UICollectionViewDelegateFlowLayout {
       @IBOutlet private var cv : UICollectionView!
       private var scaleValue: CGFloat!
       private var windowSize : CGFloat!
       private var currentIndex : Int = 0
       private var lastCenteredTargetIndex : IndexPath!
       
       var behavior = MSCollectionViewPeekingBehavior()
       
       func setup(cellPeekWidth: CGFloat, cellSpacing: CGFloat , scaleValue : CGFloat) {
           self.scaleValue = scaleValue
           behavior = MSCollectionViewPeekingBehavior.init(cellSpacing: cellSpacing, cellPeekWidth: cellPeekWidth)
           cv.configureForPeekingBehavior(behavior: behavior)
           cv.delegate = self
           //collectionView.contentInset = UIEdgeInsets(top: 0, left: insetValue, bottom: 0, right: insetValue)
         
       }
    
    public func getEmbeddedCollectionView()-> UICollectionView{
        return self.cv
    }
       
       override func draw(_ rect: CGRect) {
           super.draw(rect)
           updateCellsLayout()
           self.windowSize = getWindowSize()
           self.lastCenteredTargetIndex = getCurrentTargetIndex()
       }
       
       private func getWindowSize()-> CGFloat{
           var c1 : UICollectionViewCell!
           var c2 : UICollectionViewCell!
           var i = 0
           for cell in cv.visibleCells{
               //print("in visible cells")
               if i == 0 {c1 = cell}
               else if i==1 {
                   c2 = cell
                   break
               }
               i+=1
           }
           if let cellA = c1 , let cellB = c2{
               var distance = cellB.center.x - cellA.center.x
               if distance < 0 {distance *= -1}
               return distance
           }
           else{
               return cv.frame.size.width
           }
       }
       
       private func getCurrentCenteredTargetCell() -> UICollectionViewCell{
           let centerX = cv.contentOffset.x + (cv.frame.size.width)/2
           var minOffset : CGFloat = CGFloat.greatestFiniteMagnitude
           var minOffsetCell : UICollectionViewCell!
           for cell in cv.visibleCells{
               var offsetX = centerX - cell.center.x
               if offsetX < 0{offsetX *= -1} //abs
               if offsetX < minOffset {
                   minOffset = offsetX
                   minOffsetCell = cell
               }
           }
           return minOffsetCell
       }
       
       
       private func getCurrentTargetIndex() -> IndexPath {
           if let ip = cv.indexPath(for: getCurrentCenteredTargetCell()){
               return ip
           }
           return IndexPath.init(row: 0, section: 0)
       }
       
       private func getAlphaValueBasedOnScrolling() -> CGFloat{
           let centerX = cv.contentOffset.x + (cv.frame.size.width)/2
           var minOffset : CGFloat = CGFloat.greatestFiniteMagnitude
           for cell in cv.visibleCells{
               var offsetX = centerX - cell.center.x
               if offsetX < 0{offsetX *= -1} //abs
               if offsetX < minOffset {
                   minOffset = offsetX
               }
           }
           let alpha = 1-(minOffset / (self.windowSize/2))
           return alpha
           //print("Wsize:", self.windowSize , "minoffset: ", minOffset)
       }

       func updateCellsLayout() {
           let centerX = cv.contentOffset.x + (cv.frame.size.width)/2
           for cell in cv.visibleCells {
               var offsetX = centerX - cell.center.x
               if offsetX < 0 {
                      offsetX *= -1
               }
               cell.transform = CGAffineTransform.identity
               let offsetPercentage = offsetX / (cv.superview!.bounds.width * scaleValue)
               let scaleX = 1-offsetPercentage
               cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
           }
       }

          internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              var cellSize: CGSize = collectionView.bounds.size
              cellSize.width -= collectionView.contentInset.left * 2
              cellSize.width -= collectionView.contentInset.right * 2
              cellSize.height = cellSize.width
              return cellSize
          }
       
       func scrollViewDidScroll(_ scrollView: UIScrollView) {
           updateCellsLayout()
           let v = getAlphaValueBasedOnScrolling()
           updateTargetIndex()
           
           
       }
       private func updateTargetIndex(){
           let current = getCurrentTargetIndex()
           if lastCenteredTargetIndex != current{
               lastCenteredTargetIndex = current
               print(current) //notify
           }
       }
       
       
       func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
               behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
       }

}
