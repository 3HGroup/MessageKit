//
//  RSVPPhotoLikeMessageCell.swift
//  MessageKit
//
//  Created by Liyu Wang on 15/8/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import UIKit

let RSVP_likedPhotoSize = CGSize(width: 70, height: 70)
let RSVP_heartSize = CGSize(width: 21, height: 21)
let RSVP_photoLikeCellPadding: CGFloat = 8.0

open class RSVPPhotoLikeMessageCell: MessageContentCell {
    
    open var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10.0
        return imageView
    }()
    
    open var heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    open var messageLabel: MessageLabel = {
        let ml = MessageLabel()
        ml.baselineAdjustment = .alignCenters
        ml.numberOfLines = 3 
        return ml
    }()
        
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            messageLabel.heightAnchor.constraint(lessThanOrEqualToConstant: messageContainerView.frame.height),
            messageLabel.centerYAnchor.constraint(equalTo: messageContainerView.centerYAnchor)
        ])
    }
    
    open override func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(imageView)
        messageContainerView.addSubview(heartImageView)
        messageContainerView.addSubview(messageLabel)
        setupConstraints()
    }
    
    open func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.constraint(equalTo: RSVP_likedPhotoSize)
        heartImageView.constraint(equalTo: RSVP_heartSize)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor, constant: RSVP_photoLikeCellPadding),
            imageView.topAnchor.constraint(equalTo: messageContainerView.topAnchor, constant: RSVP_photoLikeCellPadding),
            imageView.bottomAnchor.constraint(greaterThanOrEqualTo: messageContainerView.bottomAnchor, constant: -RSVP_photoLikeCellPadding),
            
            messageLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: RSVP_photoLikeCellPadding),
            
            heartImageView.leadingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: RSVP_photoLikeCellPadding / 2),
            heartImageView.topAnchor.constraint(equalTo: messageContainerView.topAnchor, constant: RSVP_photoLikeCellPadding),
            heartImageView.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -RSVP_photoLikeCellPadding),
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
            messageLabel.textColor = textColor
            heartImageView.image = textColor == .white ? #imageLiteral(resourceName: "liked_white.png") : #imageLiteral(resourceName: "liked_green.png")
            messageLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)!
            messageLabel.text = text
        }
    }
}
