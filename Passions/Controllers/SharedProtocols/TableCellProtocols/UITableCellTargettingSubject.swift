//
//  UITableCellTargettingSubject.swift
//  Passions
//
//  Created by Simone Scionti on 07/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation

protocol UITableCellTargettingSubject {
    var targetObserver:  UITableCellTargettingObserver! { get set }
}
