//
//  ConversationService.swift
//  Chat-0.1
//
//  Created by Sunrise on 22.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation
import UIKit

protocol ConversationService {
    
    func setChannel(channel: Channel?)
    func getArrayChannel() -> Array<Channel>
    func getArrayMessage() -> Array<Message>
    func removeListenerForChannel()
    func removeListenerForMessage()
    func setTableView(_ tableView: UITableView)
    func addListenerForChannel()
     func addDocumentForChannel(name: String)
     func addListenerForMessage()
    func addDocumentForMessage(_ message: Message)
}
