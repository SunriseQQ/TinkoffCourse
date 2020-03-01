//
//  TableViewCell.swift
//  Chat-0.1
//
//  Created by Sunrise on 28.02.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell, ConfigurableView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with model: ConversationCellModel){
        nameLabel.text = model.name
        
        if model.message == nil {
            let fontSize = self.messageLabel.font.pointSize;
            messageLabel.text = "No messages yet"
            messageLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: fontSize)
        } else {
            messageLabel.text = model.message
        }
        
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInToday(model.date) {
            dateFormatter.dateFormat = "HH:mm"
            dateLabel.text = dateFormatter.string(from: model.date)
        } else {
            dateFormatter.dateFormat = "dd MMM"
            dateLabel.text = dateFormatter.string(from: model.date)
        }
        
        if model.isOnline  {
            contentView.backgroundColor = UIColor(hex: "#FFFCDCFF")
        }
        
        if model.hasUnreadMessages {
            let fontSize = self.messageLabel.font.pointSize;
            messageLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        contentView.backgroundColor = UIColor(hex: "#FFFFFFFF")
        // messageLabel.font = UIFont(name: "SystemRegular", size: messageLabel.font.pointSize)
        messageLabel.font = UIFont.systemFont(ofSize: messageLabel.font.pointSize)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
