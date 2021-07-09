//
//  DataBaseTestFile.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 06.07.2021.
//

import Foundation
import RealmSwift

class SomeTestEntity: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var gender = true
    @objc dynamic var petName = ""
}


