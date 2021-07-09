//
//  FriendPhotos.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 07.07.2021.
//

import Foundation
import RealmSwift

protocol FriendPhotoDataSourceRealm: Object {
    var photoReference: String? {get}
    var friendId: FriendRealm? {get}
}


class FriendPhotoRealm: Object, FriendPhotoDataSourceRealm {
    @objc dynamic var photoReference: String?
    @objc dynamic var friendId: FriendRealm?
    
    convenience init(friendId: FriendRealm?, photoReference: String?) {
        self.init()
        self.photoReference = photoReference
        self.friendId = friendId
    }
    
    override static func primaryKey() -> String? {
        return "photoReference"
    }
}

