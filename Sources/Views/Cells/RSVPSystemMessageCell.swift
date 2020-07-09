//
//  RSVPSystemMessageCell.swift
//  MessageKit
//
//  Created by Liyu Wang on 15/10/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import UIKit

let RSVP_SystemMsgCellIconSize: CGFloat = 25.0 
let RSVP_SystemMsgCellPadding: CGFloat = 11.0

open class RSVPSystemMessageCell: MessageContentCell {
    open var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    open var favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    open var messageLabel = MessageLabel()
    
    var labelCenterYConstraint: NSLayoutConstraint!
    var labelConstraint: NSLayoutConstraint!
    var iconSizeContraint: NSLayoutConstraint!
    var favImageViewConstraint: NSLayoutConstraint!
    var isFavouritePhoto: Bool = false
    
    open override func setupSubviews() {
        super.setupSubviews()
         
        labelCenterYConstraint = messageLabel.centerYAnchor.constraint(equalTo: messageContainerView.centerYAnchor)
        labelConstraint = messageLabel.topAnchor.constraint(equalTo: messageContainerView.topAnchor, constant: RSVP_SystemMsgCellPadding)
        iconSizeContraint = imageView.widthAnchor.constraint(equalToConstant: RSVP_SystemMsgCellIconSize)
        favImageViewConstraint = favoriteImageView.bottomAnchor.constraint(equalTo: messageContainerView.bottomAnchor, constant: -RSVP_SystemMsgCellPadding)
        
        messageContainerView.addSubview(imageView)
        messageContainerView.addSubview(messageLabel)
        messageContainerView.addSubview(favoriteImageView)
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        favoriteImageView.image = nil
    }
    
    open func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
         
        favoriteImageView.layer.cornerRadius = 10
        messageLabel.baselineAdjustment = .alignCenters
        messageLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            labelConstraint,
            labelCenterYConstraint,
            messageLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: RSVP_SystemMsgCellPadding),
            messageLabel.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -RSVP_SystemMsgCellPadding),
           
            iconSizeContraint,
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0),
            imageView.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor, constant: RSVP_SystemMsgCellPadding),
            imageView.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor),
            
            favoriteImageView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: RSVP_SystemMsgCellPadding),
            favoriteImageView.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor, constant: RSVP_SystemMsgCellPadding),
            favoriteImageView.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -RSVP_SystemMsgCellPadding),
            favImageViewConstraint
        ])
        
        if isFavouritePhoto == false {
            labelCenterYConstraint.isActive = true
            labelConstraint.isActive = false
        } else {
            labelCenterYConstraint.isActive = false
            labelConstraint.isActive = true

        }
    }
    
    override open func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError(MessageKitError.nilMessagesDisplayDelegate)
        }
 
        isFavouritePhoto = false
        if case .rsvpSystem(let systemItem) = message.kind {
            switch systemItem.style {
            case .sysDefault, .historyDeleted:
                iconSizeContraint.constant = 0
                favImageViewConstraint.constant = RSVP_SystemMsgCellPadding * 2
                labelConstraint.constant = 0
            case .favorite, .tag, .encrypted, .contacts, .expired, .rejected, .tagRequest, .calling:
                iconSizeContraint.constant = RSVP_SystemMsgCellIconSize
                favImageViewConstraint.constant = RSVP_SystemMsgCellPadding * 2
                labelConstraint.constant = 0
            case .favoritePhoto:
                isFavouritePhoto = true 
                labelConstraint.constant = RSVP_SystemMsgCellPadding
                iconSizeContraint.constant = RSVP_SystemMsgCellIconSize
                favImageViewConstraint.constant = -RSVP_SystemMsgCellPadding
            }
            
            imageView.image = systemItem.icon
            messageLabel.attributedText = systemItem.attributedText

            messageLabel.numberOfLines = 0
            
            let textColor = displayDelegate.textColor(for: message, at: indexPath, in: messagesCollectionView)
            messageLabel.textColor = textColor 
        }
        setupConstraints()
    }
}
