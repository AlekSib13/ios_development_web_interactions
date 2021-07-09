//
//  Messages.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 08.07.2021.
//

import Foundation
import RealmSwift

//MARK: The template of the Message class. The template is not finished yet and the class is not ready for usage yet

class MessageRealm: Object {
    @objc dynamic var messageId: Int = 0
    @objc dynamic var friendId: Int = 0
    @objc dynamic var messageBody: String = ""
    
    override static func primaryKey() -> String? {
        return "messageId"
    }
    
}
