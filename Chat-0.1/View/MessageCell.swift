//
//  MessageCell.swift
//  Chat-0.1
//
//  Created by Sunrise on 01.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//
import UIKit

class MessageCell: UITableViewCell,  ConfigurableView
{
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    let messageLabel = UILabel()
    let messageBackgroundView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        backgroundColor = .clear
        
        messageBackgroundView.backgroundColor = .white
        messageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        messageBackgroundView.layer.cornerRadius = 12
        addSubview(messageBackgroundView)
        
        addSubview(messageLabel)
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width * 0.75 - 32),
            //Последняя четверть ширины ячейки учитывая отступ в 32
            messageBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            messageBackgroundView.leadingAnchor.constraint(equalTo:  messageLabel.leadingAnchor, constant: -16),
            messageBackgroundView.trailingAnchor.constraint(equalTo:  messageLabel.trailingAnchor, constant: 16),
            messageBackgroundView.bottomAnchor.constraint(equalTo:  messageLabel.bottomAnchor, constant: 16)]
        
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint.isActive = true
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint.isActive = true
        
        
    }
    
    func configure(with model: MessageCellModel){
        
        messageLabel.text = model.text
        //        messageBackgroundView.backgroundColor = model.isIncoming ? UIColor(hex: "#FFDD2DFF") : .darkGray
        //        messageLabel.textColor = model.isIncoming ? .black : .white
        
        if model.isIncoming {
            messageBackgroundView.backgroundColor = UIColor(hex: "#FFDD2DFF")
            messageLabel.textColor = .black
            leadingConstraint.isActive = true
            trailingConstraint.isActive = false
        } else {
            messageBackgroundView.backgroundColor = .darkGray
            messageLabel.textColor = .white
            leadingConstraint.isActive = false
            trailingConstraint.isActive = true
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

