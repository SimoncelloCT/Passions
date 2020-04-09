//
//  HorizontalCollectionView.swift
//  Passions
//
//  Created by Simone Scionti on 05/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class SSCollectionView: UIView, UICollectionViewDelegate, UIScrollViewDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet private var cv : UICollectionView!
    private var scaleValue: CGFloat!
    private var windowSize : CGFloat!
    private var lastCenteredTargetIndex : Int!
    private var previousCenteredTargetIndex :Int!
    public weak var dataSource : SSCVDataSource!
    public weak var signalObserver : SSCVSignalUpdateObserver!
    private var lastRadius : CGFloat = 10.0
    private var defaultRadius :CGFloat = 10.0
    
    var behavior = MSCollectionViewPeekingBehavior()
    func setup(cellPeekWidth: CGFloat, cellSpacing: CGFloat , scaleValue : CGFloat) {
        self.scaleValue = scaleValue
        behavior = MSCollectionViewPeekingBehavior.init(cellSpacing: cellSpacing, cellPeekWidth: cellPeekWidth)
        cv.configureForPeekingBehavior(behavior: behavior)
        cv.delegate = self
        cv.dataSource = self
    }
    
    func setStatusTo(index: Int, animated : Bool = false){
        let signalOb = signalObserver
        signalObserver = nil //do not notify for this scroll
        behavior.scrollToItem(at: index, animated: animated)
        setNeedsDisplay()
        signalObserver = signalOb
    }
    
    func getDefaultRadius()-> CGFloat{
        return defaultRadius
    }
    
    func resetStatus(){
        let signalOb = signalObserver
        signalObserver = nil //do not notify for this scroll
        behavior.scrollToItem(at: 0, animated: false)
        signalObserver = signalOb
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if let ds = dataSource{
               return ds.SSCV(collectionView, numberOfItemsInSection: section)
            }
            return 0
       }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let ds = dataSource{
            let cell = ds.SSCV(collectionView, cellForItemAt: indexPath)
            if let c = cell as? CollectionContentCollectionViewCell{
                if lastRadius != defaultRadius {
                    c.setCornerRadius(radius: lastRadius)
                }
            }
           return cell
        }
        return UICollectionViewCell()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateCellsLayout()
        self.windowSize = getWindowSize()
        self.lastCenteredTargetIndex = getCurrentTargetIndex()
        self.previousCenteredTargetIndex = lastCenteredTargetIndex
    }
       
    private func getWindowSize()-> CGFloat{
        var c1 : UICollectionViewCell!
        var c2 : UICollectionViewCell!
        var i = 0
        for cell in cv.visibleCells{
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
    
    public func updateCellsCornerRadius(radius r :CGFloat){
        lastRadius = r
        if lastRadius != defaultRadius {
            for cell in cv.visibleCells {
                    if let c = cell as? CollectionContentCollectionViewCell{
                    c.setCornerRadius(radius: r)
                }
            }
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
            if let  cell = minOffsetCell{
                return cell
            }
            return UICollectionViewCell()
        }
       
        public func getCell(forIndex i: Int) -> UICollectionViewCell?{
            return cv.cellForItem(at: IndexPath.init(row: i, section: 0))
        }
       
       private func getCurrentTargetIndex() -> Int {
           if let ip = cv.indexPath(for: getCurrentCenteredTargetCell()){
            return ip.row
           }
           return 0
       }
       
       private func getAlphaValueBasedOnScrolling() -> CGFloat{
        guard windowSize != nil else{return 1.0} //cell is not drawn
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
            updateTargetIndex()
            let v = getAlphaValueBasedOnScrolling()
            if let so = signalObserver {
                so.alphaChanged(alpha: v)
            }
       }
    
       private func updateTargetIndex(){
            let current = getCurrentTargetIndex()
            if lastCenteredTargetIndex != current{
                previousCenteredTargetIndex = lastCenteredTargetIndex
                lastCenteredTargetIndex = current
                if let so = signalObserver{
                    so.targetIndexChanged(targetIndex: current, previousTargetIndex: previousCenteredTargetIndex)
               }
            }
       }
       
       func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
               behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
       }

}
