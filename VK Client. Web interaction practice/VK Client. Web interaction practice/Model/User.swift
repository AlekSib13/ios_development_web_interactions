//
//  User.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 06.07.2021.
//

import Foundation
import RealmSwift


// Не забыть написать написать оверрайд статик функ праймери ки

protocol UserDataSourceRealm {
    var id: Int {get}
    var firstName: String? {get}
    var lastName: String? {get}
    var birthday: String? {get}
    var sex: String? {get}
}

class UserRealm: Object, UserDataSourceRealm {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String? = nil
    @objc dynamic var lastName: String? = nil
    @objc dynamic var birthday: String? = nil
    @objc dynamic var sex: String? = nil
    
    let friends = List<FriendRealm>()
    let groups = List<GroupRealm>()
    

    
    convenience init(id: Int, firstName: String?, lastName: String?, birthday: String?, sex: String?) {
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.birthday = birthday
        self.sex = sex
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
