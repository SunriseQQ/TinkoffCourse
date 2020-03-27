//
//  ConversationsListViewController.swift
//  Chat-0.1
//
//  Created by Sunrise on 28.02.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit
import Firebase



class ConversationsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    private var serviceForChat: ConversationService = FirebaseService()
    private var timer: Timer?
    private var  headerTitles = ["Active", "Inactive"]
    private var currentChannelAlertController: UIAlertController?
    private var isActiveChannels: Array<Any>?
    private var isInactiveChannels: Array<Any>?
    private let toolbarLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: ChannelCell.self),
                                 bundle: Bundle.main),
                           forCellReuseIdentifier: String(describing: ChannelCell.self))
        
        //   tableView.register(UITableViewCell.self, forCellReuseIdentifier: firebase.channelCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        toolbarItems = [
            
            UIBarButtonItem(customView: toolbarLabel),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toolBarButtonPressed)),
        ]
        
        
        setupNavigationBar()
        //firebase.tableView = tableView
        serviceForChat.setTableView(tableView)
        serviceForChat.addListenerForChannel()
        //firebase.createChannel(name: "aaa")
        self.timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(timerReloadData), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer ?? Timer(), forMode: .default)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isToolbarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isToolbarHidden = true
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = String(describing: ChannelCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ChannelCell
            else { return UITableViewCell() }
        guard let channelCellModelFromFirebase =  ChannelCellModel(serviceForChat.getArrayChannel()[indexPath.row])
            else {return UITableViewCell()}
        cell.configure(with: channelCellModelFromFirebase)
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceForChat.getArrayChannel().count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let conversationViewController = mainStoryboard.instantiateViewController(withIdentifier: "ConversationViewController") as! ConversationViewController
        navigationController?.pushViewController(conversationViewController, animated: true)
        guard let channelCellModelFromFirebase =  ChannelCellModel(serviceForChat.getArrayChannel()[indexPath.row])
            else {return }
        conversationViewController.serviceForChat.setChannel(channel: serviceForChat.getArrayChannel()[indexPath.row])
        conversationViewController.title = channelCellModelFromFirebase.name
        
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Tinkoff Chat"
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .done, target: self, action: #selector(barButtonItemPressed))
    }
    
    
    @objc private func barButtonItemPressed(sender: UIBarButtonItem) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileViewController = mainStoryboard.instantiateViewController(withIdentifier: "navigationProfileController") as! UINavigationController
        present(profileViewController, animated: true, completion: nil)
    }
    
    
    @objc private func toolBarButtonPressed() {
        let ac = UIAlertController(title: "Create a new Channel", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addTextField { field in
            field.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            field.enablesReturnKeyAutomatically = true
            field.autocapitalizationType = .words
            field.clearButtonMode = .whileEditing
            field.placeholder = "Channel name"
            field.returnKeyType = .done
            field.tintColor = UIColor(hex: "#FFDD2DFF")
        }
        let createAction = UIAlertAction(title: "Create", style: .default, handler: { _ in
            self.serviceForChat.addDocumentForChannel(name: ac.textFields?.first?.text ?? "")
        })
        createAction.isEnabled = false
        ac.addAction(createAction)
        ac.preferredAction = createAction
        
        present(ac, animated: true) {
            ac.textFields?.first?.becomeFirstResponder()
        }
        currentChannelAlertController = ac
    }
    @objc private func textFieldDidChange(_ field: UITextField) {
        guard let ac = currentChannelAlertController else {
            return
        }
        
        ac.preferredAction?.isEnabled = field.hasText
    }
    @objc private func timerReloadData(){
        tableView.reloadData()
    }
}

