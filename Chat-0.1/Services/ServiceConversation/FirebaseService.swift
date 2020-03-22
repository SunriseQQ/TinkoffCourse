//
//  FirebaseService.swift
//  Chat-0.1
//
//  Created by Sunrise on 19.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation
import Firebase


class FirebaseService: ConversationService {
    
    
    private var channels = [Channel]()
    private var tableView: UITableView?
    private var channel: Channel?
    
    private var messages = [Message]()
    private var message: Message?
    
    
    //не забыть сделать прайват и выполнить остальное
    private var messageListener: ListenerRegistration?
    private var channelListener: ListenerRegistration?
    private  lazy var db = Firestore.firestore()
    private  lazy var referenceChannel = db.collection("channels")
    private lazy var referenceMessage: CollectionReference = {
        guard let channelIdentifier = channel?.identifier  else { fatalError() }
        return db.collection("channels").document(channelIdentifier).collection("messages")     }()
    
    func setChannel(channel: Channel?) {
        self.channel = channel
        return
    }
    
    func getArrayChannel() -> Array<Channel> {
        return channels
    }
    
    func getArrayMessage() -> Array<Message>{
        return messages
    }
    
    func removeListenerForChannel(){
        channelListener?.remove()
    }
    func removeListenerForMessage(){
        messageListener?.remove()
    }
    
    func setTableView(_ tableView: UITableView){
        self.tableView = tableView
    }
    
    func addListenerForChannel() {
        channelListener = referenceChannel.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            
            snapshot.documentChanges.forEach { change in
                
                self.handleDocumentChangeChannel(change)
            }
        }
    }
    
    
    
    func addDocumentForChannel(name: String) {
        
        let channel = Channel(name: name)
        referenceChannel.addDocument(data: channel.representation) { error in
            if let e = error {
                print("Error saving channel: \(e.localizedDescription)")
            }
        }
    }
    
    func addListenerForMessage() {
        messageListener = referenceMessage.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChangeMessage(change)
            }
        }
    }
    
    func addDocumentForMessage(_ message: Message){
        referenceMessage.addDocument(data: message.representation) { error in
            if let e = error {
                print("Error sending message: \(e.localizedDescription)")
                return
            }
        }
    }
    
    private func addChannelToTable(_ channel: Channel) {
        
        channels.append(channel)
        channels.sort(by: >)
        guard let index = channels.firstIndex(of: channel) else {
            return
        }
        tableView?.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView?.reloadData()
    }
    
    private func updateChannelInTable(_ channel: Channel) {
        guard let index = channels.firstIndex(of: channel) else {
            return
        }
        
        channels[index] = channel
        channels.sort(by: >)
        tableView?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView?.reloadData()
    }
    
    private func removeChannelFromTable(_ channel: Channel) {
        guard let index = channels.firstIndex(of: channel) else {
            return
        }
        channels.remove(at: index)
        channels.sort(by: >)
        tableView?.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView?.reloadData()
    }
    
    
    private func handleDocumentChangeChannel(_ change: DocumentChange) {
        
        guard let channel = Channel(document: change.document) else {
            return
        }
        
        switch change.type {
        case .added:
            addChannelToTable(channel)
            
        case .modified:
            updateChannelInTable(channel)
            
        case .removed:
            removeChannelFromTable(channel)
        }
    }
    
    private func insertNewMessage(_ message: Message) {
        messages.append(message)
        messages.sort(by: >)
        guard let index = messages.firstIndex(of: message) else {
            return
        }
        
        tableView?.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        //tableView?.scrollToRow(at: IndexPath(item: self.messages.count-1, section: 0), at: .bottom, animated: true)
        
        tableView?.reloadData()
        
    }
    
    private func handleDocumentChangeMessage(_ change: DocumentChange) {
        guard let message = Message(document: change.document) else {
            return
        }
        
        switch change.type {
        case .added:
            insertNewMessage(message)
        default:
            break
        }
    }
}
