//
//  Message\.swift
//  Chat-0.1
//
//  Created by Sunrise on 19.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation
import Firebase

struct  Message {
   
    let content: String
    let created: Date
    let senderId: String
    let senderName: String
    
    init(content: String) {
        self.senderName = "lopuh"
        self.content = content
        self.senderId = "myIdIsMyIdAndOnlyMine"
        self.created = Date()
       
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let created = data["created"] as? Timestamp else {
            return nil
        }
        guard let senderID = data["senderID"] as? String else {
            return nil
        }
        guard let senderName = data["senderName"] as? String else {
            return nil
        }
        guard let content = data["content"] as? String else {
            return nil
        }
        
        self.created = Date(timeIntervalSince1970: TimeInterval(created.seconds))
        self.senderId = senderID
        self.senderName = senderName
        self.content = content
    }
}
extension Message {
    var representation: [String: Any] {
        return ["content": content,
                "created": Timestamp(date: created),
                "senderID": senderId,
                "senderName": senderName]
    }
}
extension Message: Comparable {
  
  static func == (lhs: Message, rhs: Message) -> Bool {
    return true//lhs.identifier == rhs.identifier
  }
  
  static func < (lhs: Message, rhs: Message) -> Bool {
    return lhs.created < rhs.created
  }
  
}
