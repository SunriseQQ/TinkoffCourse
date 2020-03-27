//
//  ChatCellModel.swift
//  Chat-0.1
//
//  Created by Sunrise on 01.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation

struct MessageCellModel {
   // let text: String
    let isIncoming: Bool
    let content: String
    let created: Date
    let senderId: String
    let senderName: String
    
    
    init() {
        let myId = "myIdIsMyIdAndOnlyMine"
        self.content = ""
        self.created = Date()
        self.senderId = ""
        self.senderName = ""
        if self.senderId == myId {
            self.isIncoming = false
        } else {
             self.isIncoming = true
        }
    }
    
    init?(_ message: Message){
        let myId = "myIdIsMyIdAndOnlyMine"
        self.content = message.content
        self.created = message.created
        self.senderId = message.senderId
        self.senderName = message.senderName
        if self.senderId == myId {
            self.isIncoming = false
        } else {
             self.isIncoming = true
        }
    }
}
