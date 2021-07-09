//
//  SaverReaderDbService.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 08.07.2021.
//

import Foundation
import RealmSwift

class SaverReaderDbservice {
    
    let realmConfig = Realm.Configuration(schemaVersion: 3)
    lazy var realm = try! Realm(configuration: realmConfig)
    
    enum ReadErrors: Error {
        case noSuchCellIdentifier
    }

    
    
    func saveToDb(listOfObjects: [AnyObject]) {
        print(realm.configuration.fileURL)
        
    
        realm.beginWrite()
        for element in listOfObjects {
            if let elementRealm = element as? FriendRealm {
                realm.add(elementRealm, update: .modified)
            } else if let elementRealm = element as? GroupRealm {
                realm.add(elementRealm, update: .modified)
            } else if let elementRealm = element as? FriendPhotoRealm {
                realm.add(elementRealm, update: .modified)
            } else if let elementRealm = element as? GroupPhotoRealm {
                realm.add(elementRealm, update: .modified)
            }
            else {continue}}
        
        do {try realm.commitWrite()} catch {print(error)}
    }
    

    func retrieveFromDb (cellIdentifierName: String) throws -> Any {
        
        if cellIdentifierName == "friendsListTableViewCellIdentifier" {
            let result = realm.objects(FriendRealm.self)
            return result
        } else if cellIdentifierName == "groupsListTableViewCellIdentifier"{
            let result = realm.objects(GroupRealm.self)
            return result
        } else {throw ReadErrors.noSuchCellIdentifier}
    }
}



