//
//  RSVPSystemMessageCell.swift
//  MessageKit
//
//  Created by Liyu Wang on 15/10/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import UIKit

let RSVP_SystemMsgCellIconSize: CGFloat = 25.0
let RSVP_SystemMsgCellTitleHeight: CGFloat = 11.0
let RSVP_SystemMsgCellPadding: CGFloat = 10.0

open class RSVPSystemMessageCell: MessageContentCell {
    open var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    open var messageLabel = MessageLabel()
    
    var iconSizeContraint: NSLayoutConstraint!
    
    open override func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(imageView)
        messageContainerView.addSubview(messageLabel)
        setupConstraints()
    }
    
    open func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.iconSizeContraint = imageView.widthAnchor.constraint(equalToConstant: RSVP_SystemMsgCellIconSize)
        
        NSLayoutConstraint.activate([
            self.iconSizeContraint,
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0),
            imageView.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor, constant: RSVP_SystemMsgCellPadding),
            imageView.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: messageContainerView.topAnchor, constant: RSVP_SystemMsgCellPadding),
            messageLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: RSVP_SystemMsgCellPadding),
            messageLabel.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -RSVP_SystemMsgCellPadding),
            messageLabel.bottomAnchor.constraint(equalTo: messageContainerView.bottomAnchor, constant: -RSVP_SystemMsgCellPadding)
        ])
    }
    
    override open func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError(MessageKitError.nilMessagesDisplayDelegate)
        }
        
        if case .rsvpSystem(let systemItem) = message.kind {
            switch systemItem.style {
            case .sysDefault:
                iconSizeContraint.constant = 0
            case .favorite, .tag, .encrypted:
                iconSizeContraint.constant = RSVP_SystemMsgCellIconSize
            }
            
            imageView.image = systemItem.icon
            messageLabel.attributedText = systemItem.attributedText
            
            let textColor = displayDelegate.textColor(for: message, at: indexPath, in: messagesCollectionView)
            messageLabel.textColor = textColor 
        }
    }
}
