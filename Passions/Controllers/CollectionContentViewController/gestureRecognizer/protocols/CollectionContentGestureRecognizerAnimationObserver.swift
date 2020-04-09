//
//  CollectionContentGestureRecognizerAnimationObserver.swift
//  Passions
//
//  Created by Simone Scionti on 08/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation

protocol CollectionContentGestureRecognizerAnimationObserver : class {
    func didMoveToCenter()
    func didMoveToBottom()
}
