//
//  MainPageViewController.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 30.06.2021.
//

import UIKit
import RealmSwift

class MainPageViewController: UIViewController {
    
    var urlComponents = URLComponents()
    let configuration = URLSessionConfiguration.default
    let databaseService = SaverReaderDbservice()
    
    var listOfRealmObjects = [AnyObject]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Singleton.shared.session = URLSession(configuration: configuration)
        
        //MARK: the code of getting data from API was moved to the viewWillAppear method in order to recieve updates of groups and friends information each time a user switches to his main screen
//        let session = Singleton.shared.session!
        
//        loadFriendsList(session: session){
//            let apiAcess = VKApiServiceParams(schema: "https", host: "api.vk.com", path: "/method",methodToPath: "/friends.get")
//            urlComponents.scheme = apiAcess.schema
//            urlComponents.host = apiAcess.host
//            urlComponents.path = apiAcess.path + apiAcess.methodToPath
//            urlComponents.queryItems = [
//                URLQueryItem(name: "owner_id", value: Singleton.shared.userId),
//                URLQueryItem(name: "fields", value: "nickname,domain,sex,bdate,city,photo_50,photo_100"),
//                URLQueryItem(name: "access_token", value: Singleton.shared.token),
//                URLQueryItem(name: "v", value: "5.131")]
//            let url = urlComponents.url!
//            return url
//        }
//
//
//        loadGroupsInfo(session: session){
//            let apiAcess = VKApiServiceParams(schema: "https", host: "api.vk.com", path: "/method",methodToPath: "/groups.get")
//            urlComponents.scheme = apiAcess.schema
//            urlComponents.host = apiAcess.host
//            urlComponents.path = apiAcess.path + apiAcess.methodToPath
//            urlComponents.queryItems = [
//                URLQueryItem(name: "owner_id", value: Singleton.shared.userId),
//                URLQueryItem(name: "extended", value: "1"),
//                URLQueryItem(name: "access_token", value: Singleton.shared.token),
//                URLQueryItem(name: "v", value: "5.131")]
//            let url = urlComponents.url!
//            return url
//        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let session = Singleton.shared.session!
        
        loadFriendsList(session: session){
            let apiAcess = VKApiServiceParams(schema: "https", host: "api.vk.com", path: "/method",methodToPath: "/friends.get")
            urlComponents.scheme = apiAcess.schema
            urlComponents.host = apiAcess.host
            urlComponents.path = apiAcess.path + apiAcess.methodToPath
            urlComponents.queryItems = [
                URLQueryItem(name: "owner_id", value: Singleton.shared.userId),
                URLQueryItem(name: "fields", value: "nickname,domain,sex,bdate,city,photo_50,photo_100"),
                URLQueryItem(name: "access_token", value: Singleton.shared.token),
                URLQueryItem(name: "v", value: "5.131")]
            let url = urlComponents.url!
            return url
        }
        
        
        loadGroupsInfo(session: session){
            let apiAcess = VKApiServiceParams(schema: "https", host: "api.vk.com", path: "/method",methodToPath: "/groups.get")
            urlComponents.scheme = apiAcess.schema
            urlComponents.host = apiAcess.host
            urlComponents.path = apiAcess.path + apiAcess.methodToPath
            urlComponents.queryItems = [
                URLQueryItem(name: "owner_id", value: Singleton.shared.userId),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "access_token", value: Singleton.shared.token),
                URLQueryItem(name: "v", value: "5.131")]
            let url = urlComponents.url!
            return url
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        databaseService.saveToDb(listOfObjects: listOfRealmObjects)
        
        
    }
}




extension MainPageViewController {
    func loadGroupsInfo(session: URLSession, specifyInfo: () -> URL) {
        let url = specifyInfo()
        
        let task = session.dataTask(with: url){data, response, error
            in
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers), let parsedJson = json as? [String:Any],
                  let jsonBody = parsedJson["response"] as? [String:Any],
                  let listOfElements = jsonBody["items"] as? Array<Any>  else {return}
            
            for element in listOfElements {
                if let elementDictOfParams = element as? [String: Any] {
                    guard let id = elementDictOfParams["id"] as? UInt else {continue}
                    let name = elementDictOfParams["name"] as? String ?? "no name"
                    let avatarLinkImage = elementDictOfParams["photo_100"] as? String ?? "no photo"
                    
                    
                    
                    if let avatarLink = URL(string: avatarLinkImage) {
                        
                        let imageDownloadTask = session.dataTask(with: avatarLink){dataImage,_,errorImage in
                            if errorImage == nil {
                                if let image = dataImage {
                                    let avatarImage = UIImage(data: image)
                                    
                                    // MARK: Part of the code, which referes to the previous versions of the app. This code will be withdrawn later
//                                    Singleton.shared.listOfUserGroups.append(Group(id: id, name: name, avatar: avatarImage))
                                    
                                    self.listOfRealmObjects.append(GroupRealm(id: Int(exactly: id)!, name: name))
                                    
                                    self.listOfRealmObjects.append(GroupPhotoRealm(groupId: GroupRealm(id: Int(exactly: id)!, name: name), photoReference: avatarLinkImage))
                                    
                                }
                            } else {
                                // MARK: Part of the code, which referes to the previous versions of the app. This code will be withdrawn later
//                                Singleton.shared.listOfUserGroups.append(Group(id: id, name: name, avatar: nil))
                                
                                self.listOfRealmObjects.append(GroupRealm(id: Int(exactly: id)!, name: name))
                                
                                self.listOfRealmObjects.append(GroupPhotoRealm(groupId: GroupRealm(id: Int(exactly: id)!, name: name), photoReference: avatarLinkImage))
                            }
                        }
                        imageDownloadTask.resume()
                    } else
                    {
                        // MARK: Part of the code, which referes to the previous versions of the app. This code will be withdrawn later
//                        Singleton.shared.listOfUserGroups.append(Group(id: id, name: name, avatar: nil))
                        
                        self.listOfRealmObjects.append(GroupRealm(id: Int(exactly: id)!, name: name))
                        
                        self.listOfRealmObjects.append(GroupPhotoRealm(groupId: GroupRealm(id: Int(exactly: id)!, name: name), photoReference: avatarLinkImage))
                    }
                    
                } else {continue}
            }
        }
        task.resume()
    }
}




extension MainPageViewController {
    func loadFriendsList(session: URLSession, specifyInfo: () -> URL){
        let url = specifyInfo()
        
       

        let task = session.dataTask(with: url){data, response, erorr
            in
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers), let parsedJson = json as? [String:Any],
                  let jsonBody = parsedJson["response"] as? [String:Any],
                  let listOfElements = jsonBody["items"] as? Array<Any>  else {return}
            
            
            for element in listOfElements {
                if let elementDictOfParams = element as? [String:Any] {
                    guard let id = elementDictOfParams["id"] as? UInt else {continue}
                    let firstName = elementDictOfParams["first_name"] as? String ?? "no first name"
                    let lastName = elementDictOfParams["last_name"] as? String ?? "no last name"
                    let sex = elementDictOfParams["sex"] as? String ?? "no sex"
                    let birthday = elementDictOfParams["bdate"] as? String ?? "-"
                    let avatarLinkImage = elementDictOfParams["photo_100"] as? String ?? "no_photo"
                    
                    
                    if let avatarLink  = URL(string: avatarLinkImage) {
                        let imageDownloadTask = session.dataTask(with: avatarLink){dataImage,_,errorImage in
                            if errorImage == nil {
                                if let image = dataImage {
                                    let avatarImage = UIImage(data: image)
                                    
                                    // MARK: Part of the code, which referes to the previous versions of the app. This code will be withdrawn later
//                                    Singleton.shared.listOfUserFriends.append(Friend(id: id, firstName: firstName, lastName: lastName, avatar: avatarImage, birthday: birthday, sex: sex))
                                    
                                    self.listOfRealmObjects.append(FriendRealm.init(id: Int(exactly: id)!, firstName: firstName, lastName: lastName))
                                    
                                    self.listOfRealmObjects.append(FriendPhotoRealm(friendId: FriendRealm.init(id: Int(exactly: id)!, firstName: firstName, lastName: lastName), photoReference: avatarLinkImage))
                                    
                                }
                            } else {
                                // MARK: Part of the code, which referes to the previous versions of the app. This code will be withdrawn later
//                                Singleton.shared.listOfUserFriends.append(Friend(id: id, firstName: firstName, lastName: lastName, avatar: nil, birthday: birthday, sex: sex))
                                
                                self.listOfRealmObjects.append(FriendRealm.init(id: Int(exactly: id)!, firstName: firstName, lastName: lastName))
                                
                                self.listOfRealmObjects.append(FriendPhotoRealm(friendId: FriendRealm.init(id: Int(exactly: id)!, firstName: firstName, lastName: lastName), photoReference: avatarLinkImage))
                            }
                        }
                        imageDownloadTask.resume()
                    } else
                    {
                        // MARK: Part of the code, which referes to the previous versions of the app. This code will be withdrawn later
//                        Singleton.shared.listOfUserFriends.append(Friend(id: id, firstName: firstName, lastName: lastName, avatar: nil, birthday: birthday, sex: sex))
                        
                        self.listOfRealmObjects.append(FriendRealm.init(id: Int(exactly: id)!, firstName: firstName, lastName: lastName))
                        
                        self.listOfRealmObjects.append(FriendPhotoRealm(friendId: FriendRealm.init(id: Int(exactly: id)!, firstName: firstName, lastName: lastName), photoReference: avatarLinkImage))
                        
                    }
                } else {continue}
            }
        }
        task.resume()
    }
}




extension MainPageViewController {
    func launchTestData(completionHandler: (MessageRealm) -> Void) -> Void {
        
        let messageFromPerson = MessageRealm()
        messageFromPerson.messageId = 0
        messageFromPerson.friendId = 1
        messageFromPerson.messageBody = "Some other test message"
        completionHandler(messageFromPerson)
    }
}

