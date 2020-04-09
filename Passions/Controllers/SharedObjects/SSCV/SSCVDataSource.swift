//
//  SSCVDataSource.swift
//  Passions
//
//  Created by Simone Scionti on 05/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation
import UIKit

protocol SSCVDataSource : class {
    func SSCV(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
    func SSCV(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell    
}

