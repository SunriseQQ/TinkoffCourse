//
//  Chanel.swift
//  Chat-0.1
//
//  Created by Sunrise on 19.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation
import Firebase

struct Channel {
    let identifier: String
    let name: String
    var lastMessage: String
    var lastActivity: Date?
    
    init(name: String) {
        self.identifier = ""
        self.lastMessage = ""
        self.name = name
        self.lastActivity = Date()
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let name = data["name"] as? String else {
            return nil
        }
        guard let lastMessage = data["lastMessage"] as? String else {
            return nil
        }
        guard let date = data["lastActivity"] as? Timestamp else {
            return nil
        }
        
        identifier = document.documentID
        self.name = name
        self.lastMessage = lastMessage
        self.lastActivity = Date(timeIntervalSince1970: TimeInterval(date.seconds))
    }
    
}
extension Channel: DatabaseRepresentation {
    
    var representation: [String : Any] {
        return ["name": name,
                "lastMessage": lastMessage,
                "lastActivity": Timestamp(date: lastActivity ?? Date())]
    }
    
}

extension Channel: Comparable {
    
    static func == (lhs: Channel, rhs: Channel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    static func < (lhs: Channel, rhs: Channel) -> Bool {
        return lhs.lastActivity ?? Date() < rhs.lastActivity ?? Date()
    }
    
}
