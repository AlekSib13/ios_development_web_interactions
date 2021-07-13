//
//  FriendsListViewController.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 03.07.2021.
//

import UIKit
import RealmSwift

class UserFriendsListViewController: UIViewController, UITableViewDataSource {
    
    var realmToken: NotificationToken?
    
    @IBOutlet weak var friendsList: UITableView!
    let databaseService = SaverReaderDbservice()
    
    let cellFriendsListIdentifier = "friendsListTableViewCellIdentifier"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        friendsList.dataSource = self
        friendsList.register(UINib(nibName: "FriendsListAndGroupsListTableViewCell", bundle: nil), forCellReuseIdentifier: cellFriendsListIdentifier)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Singleton.shared.listOfUserFriends.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellFriendsListIdentifier, for: indexPath)
        
        guard let cellInfo = cell as? FriendsListAndGroupsListTableViewCell else {return UITableViewCell()}
        
        
      
        guard let resultsFromDb = databaseService.retrieveFromDb(cellIdentifierName: cellFriendsListIdentifier) as? Results<FriendPhotoRealm> else {return UITableViewCell()}
        
        
        cellInfo.configureCell(firstName: resultsFromDb[indexPath.row].friendId?.firstName, lastName: resultsFromDb[indexPath.row].friendId?.lastName, avatar: retrieveAvatar(photoReference: resultsFromDb[indexPath.row].photoReference))
        
        
        realmToken = resultsFromDb.observe{[weak self](changes: RealmCollectionChange) in
            guard let friendsList = self?.friendsList else{return}
            switch changes{
            case .initial:
                friendsList.reloadData()
            case .update(_, let delition, let insertion, let modification):
                friendsList.beginUpdates()
                friendsList.deleteRows(at: delition.map({IndexPath(row: $0, section: $0)}), with: .automatic)
                friendsList.insertRows(at: insertion.map({IndexPath(row: $0, section: $0)}), with: .automatic)
                friendsList.reloadRows(at: modification.map({IndexPath(row: $0, section: $0)}), with: .automatic)
                friendsList.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
        
        return cellInfo
    }
}

extension UserFriendsListViewController {
    func retrieveAvatar(photoReference: String?) -> UIImage? {
        
        guard let photoReferenceString = photoReference, let urlLink = URL(string: photoReferenceString) else {return nil}
        
        let dataImage = try? Data(contentsOf: urlLink)
        let avatar = UIImage(data: dataImage!)
        return avatar
    }
}




