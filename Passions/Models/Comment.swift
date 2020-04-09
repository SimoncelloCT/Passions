//
//  Comment.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation

class Comment{
    var message: String!
    var ownerProfile : Profile!
    
    init(message: String, ownerProfile: Profile) {
        self.message = message
        self.ownerProfile = ownerProfile
    }
    
}
