//
//  ConversationViewController.swift
//  Chat-0.1
//
//  Created by Sunrise on 28.02.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

class ConversationViewController: UITableViewController{
    fileprivate let cellId = "id123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.allowsSelection = false
        tableView.register(MessageCell.self, forCellReuseIdentifier: cellId)
        //  tableView.rowHeight = UITableView.automaticDimension
        //  tableView.estimatedRowHeight = 20.0
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Example.shared.messagesTextArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? MessageCell
            else { return UITableViewCell() }
        cell.configure(with: Example.shared.messagesTextArray[indexPath.row])
        return cell
    }
    
    func setupNavigationBar(){
        navigationItem.largeTitleDisplayMode = .never
    }
}
