//
//  UserGroupsListViewController.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 03.07.2021.
//

import UIKit
import RealmSwift

class UserGroupsListViewController: UIViewController,UITableViewDataSource {
    
    
    var realmToken: NotificationToken?

    @IBOutlet weak var groupsList: UITableView!
    let databaseService = SaverReaderDbservice()
    
    let cellGroupsListIdentifier = "groupsListTableViewCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        groupsList.dataSource = self
        groupsList.register(UINib(nibName: "FriendsListAndGroupsListTableViewCell", bundle: nil), forCellReuseIdentifier: cellGroupsListIdentifier)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        Singleton.shared.listOfUserGroups.count
        guard let resultsFromDb = databaseService.retrieveFromDb(cellIdentifierName: cellGroupsListIdentifier) as? Results<GroupPhotoRealm> else {return 0}
        return resultsFromDb.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellGroupsListIdentifier, for: indexPath)
        
        guard let cellInfo = cell as? FriendsListAndGroupsListTableViewCell else {return UITableViewCell()}
        
        
        
        guard let resultsFromDb = databaseService.retrieveFromDb(cellIdentifierName: cellGroupsListIdentifier) as? Results<GroupPhotoRealm> else {return UITableViewCell()}


        cellInfo.configureCell(firstName: resultsFromDb[indexPath.row].groupId?.name, lastName: nil, avatar: retrieveAvatar(photoReference: resultsFromDb[indexPath.row].photoReference))
        
        
        return cellInfo
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTableInfo()
    }
    
}



extension UserGroupsListViewController {
    func retrieveAvatar(photoReference: String?) -> UIImage? {
        
        guard let photoReferenceString = photoReference, let urlLink = URL(string: photoReferenceString) else {return nil}
        
        let dataImage = try? Data(contentsOf: urlLink)
        let avatar = UIImage(data: dataImage!)
        return avatar
    }
}


extension UserGroupsListViewController {
    
    func updateTableInfo(){
        
        guard let resultsFromDb = databaseService.retrieveFromDb(cellIdentifierName: cellGroupsListIdentifier) as? Results<GroupPhotoRealm> else {return}
        
        
        realmToken = resultsFromDb.observe{[weak self](changes: RealmCollectionChange) in
            guard let groupList = self?.groupsList else {return}
            switch changes {
            case .initial:
                groupList.reloadData()
            case .update(_, let deletion, let insertion, let modification):
                groupList.beginUpdates()
                groupList.deleteRows(at: deletion.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                groupList.insertRows(at: insertion.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                groupList.reloadRows(at: modification.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                groupList.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
}


