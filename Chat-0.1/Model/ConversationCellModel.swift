//
//  ConversationCellModel.swift
//  Chat-0.1
//
//  Created by Sunrise on 29.02.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

struct ConversationCellModel {
    let name: String
    let message: String?
    let date: Date
    let isOnline: Bool
    let hasUnreadMessages: Bool
}
