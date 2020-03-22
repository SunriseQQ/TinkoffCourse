//
//  ConversationCellModel.swift
//  Chat-0.1
//
//  Created by Sunrise on 29.02.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

struct ChannelCellModel {
    let identifier: String
    let name: String
    var lastMessage: String
    var lastActivity: Date
    var isActive: Bool
//     private  let calendar = Calendar.current
   //private  let date = calendar.date(byAdding: .minute, value: -5, to: Date())
    
    init() {
        self.identifier = ""
        self.lastMessage = ""
      self.name = ""
        self.lastActivity = Date()
        if self.lastActivity > Date().addingTimeInterval(-10 * 60.0) {
            self.isActive = true
        } else {
             self.isActive = false
        }
    }
    
    init?(_ channel: Channel){
        let date = Date().addingTimeInterval(-10 * 60.0)
        self.identifier = channel.identifier
        self.name = channel.name
        self.lastMessage = channel.lastMessage
        self.lastActivity = channel.lastActivity ?? Date()
        if self.lastActivity > date {
            self.isActive = true
        } else {
             self.isActive = false
        }
    }
    
}


