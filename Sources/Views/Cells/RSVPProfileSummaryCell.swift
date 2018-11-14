//
//  RSVPProfileSummaryCell.swift
//  MessageKit
//
//  Created by Liyu Wang on 12/11/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import UIKit

open class RSVPProfileSummaryCell: MessageContentCell {
    open var titleLabel = MessageLabel()
    open var aboutLabel = UILabel()
    
    open override func setupSubviews() {
        super.setupSubviews() 
        messageContainerView.addSubview(titleLabel)
        messageContainerView.addSubview(aboutLabel)
        setupConstraints()
    }
    
    open func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: messageContainerView.topAnchor, constant: RSVP_SystemMsgCellPadding),
            titleLabel.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor, constant: RSVP_SystemMsgCellPadding),
            titleLabel.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -RSVP_SystemMsgCellPadding),
            aboutLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            aboutLabel.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor, constant: RSVP_SystemMsgCellPadding),
            aboutLabel.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -RSVP_SystemMsgCellPadding),
            aboutLabel.bottomAnchor.constraint(equalTo: messageContainerView.bottomAnchor, constant: -RSVP_SystemMsgCellPadding)
        ])
    }
    
    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError(MessageKitError.nilMessagesDisplayDelegate)
        }
        
        let textColor = displayDelegate.textColor(for: message, at: indexPath, in: messagesCollectionView)
        titleLabel.textColor = textColor
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        titleLabel.textAlignment = .center
        
        aboutLabel.textColor = textColor
        aboutLabel.font = UIFont.systemFont(ofSize: 13)
        aboutLabel.textAlignment = .center
        aboutLabel.lineBreakMode = .byTruncatingTail
        aboutLabel.numberOfLines = 2
        
        if case .rsvpProfileSummary(let summary) = message.kind {
            titleLabel.text = summary.title
            guard summary.text?.replacingOccurrences(of: " ", with: "") != "" else {
                return
            }
            aboutLabel.text = summary.text
        }
    }
}
