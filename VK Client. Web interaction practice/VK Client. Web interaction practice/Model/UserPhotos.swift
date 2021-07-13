//
//  Photos.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 06.07.2021.
//

import Foundation
import RealmSwift

//MARK: The template of the Message class. The template is not finished yet and the class is not ready for usage yet
protocol UserPhotoDataSourceRealm {
    var photoReference: String? {get}
    var userId: UserRealm? {get}
}


class UserPhotoRealm: Object, UserPhotoDataSourceRealm {
    @objc dynamic var photoReference: String?
    @objc dynamic var userId: UserRealm?
    
    convenience init(userId: UserRealm?, photoReference: String?) {
        self.init()
        self.photoReference = photoReference
        self.userId = userId
    }
}
