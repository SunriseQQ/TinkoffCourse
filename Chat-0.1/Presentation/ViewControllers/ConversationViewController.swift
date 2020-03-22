//
//  ConversationViewController.swift
//  Chat-0.1
//
//  Created by Sunrise on 28.02.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    
    fileprivate let cellId = "id123"
    let serviceForChat: ConversationService = FirebaseService()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(MessageCell.self, forCellReuseIdentifier: cellId)
        //  tableView.rowHeight = UITableView.automaticDimension
        //  tableView.estimatedRowHeight = 20.0
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        serviceForChat.setTableView(tableView)
        serviceForChat.addListenerForMessage()
        
     
//        if (tableView.contentSize.height > tableView.frame.size.height){
//            tableView.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)
//        }
        
//        if firebase.messages.count > 0 {
//            tableView.scrollToRow(at: IndexPath(item:firebase.messages.count-1, section: 0), at: .bottom, animated: true)
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        tableView.scrollToRow(at:  IndexPath(item: serviceForChat.getArrayMessage().count-1, section: 0), at: UITableView.ScrollPosition.bottom, animated: true)
//                if firebase.messages.count > 0 {
//                    tableView.scrollToRow(at: IndexPath(item:firebase.messages.count-1, section: 0), at: .bottom, animated: true)
//                }
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return Example.shared.messagesTextArray.count
        //print(firebase.messages.count)
        return serviceForChat.getArrayMessage().count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? MessageCell
            else { return UITableViewCell() }
        
        guard let messageCellModelFromFirebase =  MessageCellModel(serviceForChat.getArrayMessage()[indexPath.row])
        else {return UITableViewCell()}
        cell.configure(with: messageCellModelFromFirebase)
        return cell
    }
    
    func setupNavigationBar(){
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: .done , target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = newBackButton
    }
     @objc func keyboardWillShow(_ notification:Notification) {

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                 self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    @objc func backButtonPressed() {
        serviceForChat.removeListenerForMessage()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func sendButtonPressed(_ sender: Any) {
        serviceForChat.addDocumentForMessage(Message(content: messageTextField.text ?? ""))
    }
}
