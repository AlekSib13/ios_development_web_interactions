//
//  GroupPhotos.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 07.07.2021.
//

import Foundation
import RealmSwift

protocol GroupPhotoDataSourceRealm {
    var photoReference: String? {get}
    var groupId: GroupRealm? {get}
}


class GroupPhotoRealm: Object, GroupPhotoDataSourceRealm {
    @objc dynamic var photoReference: String?
    @objc dynamic var groupId: GroupRealm?
    
    convenience init(groupId: GroupRealm?, photoReference: String?) {
        self.init()
        self.photoReference = photoReference
        self.groupId = groupId
    }
    
    override static func primaryKey() -> String? {
        return "photoReference"
    }
}
