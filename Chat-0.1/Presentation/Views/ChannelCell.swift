//
//  TableViewCell.swift
//  Chat-0.1
//
//  Created by Sunrise on 28.02.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell, ConfigurableView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with model: ChannelCellModel){
        nameLabel.text = model.name
        messageLabel.text = model.lastMessage
        
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInToday(model.lastActivity ) {
            dateFormatter.dateFormat = "HH:mm"
            dateLabel.text = dateFormatter.string(from: model.lastActivity )
        } else {
            dateFormatter.dateFormat = "dd MMM"
            dateLabel.text = dateFormatter.string(from: model.lastActivity )
        }
        
        if model.isActive {
            
            contentView.backgroundColor = UIColor(hex: "#FFFFFFFF")
        } else {
            contentView.backgroundColor = UIColor(hex: "#FFFCDCFF")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        contentView.backgroundColor = UIColor(hex: "#FFFFFFFF")
        messageLabel.font = UIFont.systemFont(ofSize: messageLabel.font.pointSize)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//    }
    
}
