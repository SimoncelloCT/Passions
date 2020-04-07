//
//  User.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation

class User{
    var name: String!
    var surname: String!
    var age: Int!
    init(name: String, surname: String, age: Int) {
        self.name = name
        self.surname = surname
        self.age = age
    }
}
