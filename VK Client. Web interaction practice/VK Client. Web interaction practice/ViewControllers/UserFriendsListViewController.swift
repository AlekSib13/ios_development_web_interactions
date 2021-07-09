//
//  FriendsListViewController.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 03.07.2021.
//

import UIKit
import RealmSwift

class UserFriendsListViewController: UIViewController, UITableViewDataSource {
    
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
        
        
        do {
            
            let textResultFromDb = try databaseService.retrieveFromDb(cellIdentifierName: cellFriendsListIdentifier) as! Results<FriendRealm>
            
            cellInfo.configureCell(firstName: textResultFromDb[indexPath.row].firstName, lastName: textResultFromDb[indexPath.row].lastName, avatar: nil)
            
        } catch {error}
        return cellInfo
    }
}



