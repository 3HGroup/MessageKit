//
//  RSVPPhotoLikeMessageCell.swift
//  MessageKit
//
//  Created by Liyu Wang on 15/8/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import UIKit

let RSVP_likedPhotoSize = CGSize(width: 40, height: 40)
let RSVP_photoLikeCellPadding: CGFloat = 5.0

open class RSVPPhotoLikeMessageCell: MessageContentCell {
    
    open var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5.0
        return imageView
    }()
    
    open var messageLabel = MessageLabel()
    
    open override func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(imageView)
        messageContainerView.addSubview(messageLabel)
        setupConstraints()
    }
    
    open func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.constraint(equalTo: RSVP_likedPhotoSize)
        
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -2 * RSVP_photoLikeCellPadding),
            imageView.topAnchor.constraint(equalTo: messageContainerView.topAnchor, constant: RSVP_photoLikeCellPadding),
            imageView.bottomAnchor.constraint(equalTo: messageContainerView.bottomAnchor, constant: -RSVP_photoLikeCellPadding),
            
            messageLabel.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor, constant: RSVP_photoLikeCellPadding),
            messageLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -RSVP_photoLikeCellPadding),
            messageLabel.centerYAnchor.constraint(equalTo: messageContainerView.centerYAnchor),
        ])
    }
    
    override open func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError(MessageKitError.nilMessagesDisplayDelegate)
        }
        
        if case .photoLike(let mediaItem, let text) = message.kind {
            imageView.image = mediaItem.image ?? mediaItem.placeholderImage
            
            let textColor = displayDelegate.textColor(for: message, at: indexPath, in: messagesCollectionView)
            messageLabel.text = text
            messageLabel.textColor = textColor
            messageLabel.font = UIFont.systemFont(ofSize: 15)
            messageLabel.textAlignment = .center
        }
    }
}
