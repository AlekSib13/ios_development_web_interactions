//
//  Friends.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 03.07.2021.
//

import Foundation
import UIKit
import RealmSwift


// MARK: Part of the code, which referes to the previous versions of the app. This code will be withdrawn later
//protocol FriendDataSource {
//    var id: UInt {get}
//    var firstName: String {get}
//    var lastName: String {get}
//    var avatar: UIImage? {get}
//    var birthday: String {get}
//    var sex: String {get}
//}
//
//class Friend: FriendDataSource {
//    var id: UInt
//    var firstName: String
//    var lastName: String
//    var avatar: UIImage?
//    var birthday: String
//    var sex: String
//
//    init(id: UInt, firstName: String, lastName: String, avatar: UIImage?, birthday: String, sex: String) {
//        self.id = id
//        self.firstName = firstName
//        self.lastName = lastName
//        self.avatar = avatar
//        self.birthday = birthday
//        self.sex = sex
//
//    }
//}


protocol FriendDataSourceRealm {
    var id: Int {get}
    var firstName: String? {get}
    var lastName: String? {get}
}

class FriendRealm: Object, FriendDataSourceRealm {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String? = nil
    @objc dynamic var lastName: String? = nil
    
    let groups = List<GroupRealm>()
    let users = LinkingObjects(fromType: UserRealm.self, property: "friends")
    
        
    convenience init(id: Int, firstName: String, lastName: String) {
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

