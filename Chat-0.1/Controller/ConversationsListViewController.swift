//
//  ConversationsListViewController.swift
//  Chat-0.1
//
//  Created by Sunrise on 28.02.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var headerTitles = ["Online", "History"]
    var filterArrayIsOnline = Example.shared.messagesArray.filter() {$0.isOnline}
    var filterArrayIsHistory = Example.shared.messagesArray.filter() {!$0.isOnline}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: ConversationCell.self),                                                     bundle: Bundle.main),
                           forCellReuseIdentifier: String(describing: ConversationCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        
        setupNavigationBar()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = String(describing: ConversationCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ConversationCell
            else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            let cellIsOnline = Example.shared.messagesArray.filter() {$0.isOnline}
            cell.configure(with: cellIsOnline[indexPath.row])
            return cell
        } else {
            let cellIsHistory = Example.shared.messagesArray.filter() {!$0.isOnline}
            cell.configure(with: cellIsHistory[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
        section: Int) -> String? {
        return headerTitles[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return filterArrayIsOnline.count
        } else {
            return filterArrayIsHistory.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let conversationViewController = mainStoryboard.instantiateViewController(withIdentifier: "ConversationViewController") as! ConversationViewController
        navigationController?.pushViewController(conversationViewController, animated: true)
        
        if indexPath.section == 0 {
            conversationViewController.title = filterArrayIsOnline[indexPath.row].name
        } else {
            conversationViewController.title = filterArrayIsHistory[indexPath.row].name
        }
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Tinkoff Chat"
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .done, target: self, action: #selector(barButtonItemPressed))
    }
    @objc func barButtonItemPressed(sender: UIBarButtonItem) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileViewController = mainStoryboard.instantiateViewController(withIdentifier: "navigationProfileController") as! UINavigationController
        present(profileViewController, animated: true, completion: nil)
    }
}
