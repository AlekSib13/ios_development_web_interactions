//
//  Session.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 21.06.2021.
//

import Foundation



class Singleton {
    static let shared = Singleton()
    
    
    var token = ""
    var userId = ""
    
    private init() {}
}

