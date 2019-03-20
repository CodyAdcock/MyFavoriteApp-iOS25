//
//  UserListTableViewController.swift
//  MyFavoriteApp2
//
//  Created by Cody on 3/20/19.
//  Copyright © 2019 Cody Adcock. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserController.shared.getUsers { (success) in
            if success{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UserController.shared.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)

        let user = UserController.shared.users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.favoriteApp

        return cell
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add a new User", message: nil, preferredStyle: .alert)
        
        //2 text fields
        alertController.addTextField { (textField) in
            textField.placeholder = "Add username here"
        }
        alertController.addTextField { (tf) in
            tf.placeholder = "Add favorite app name here"
        }
        //add
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alertController.textFields?[0].text,
                let favApp = alertController.textFields?[1].text else {return}
            
            UserController.shared.postUser(name: name, favoriteApp: favApp, completion: { (success) in
                if success{
                    print("succesfully created new user")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
        }
        //cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //add actions
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
