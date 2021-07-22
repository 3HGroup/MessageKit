//
//  ReplyCollectionViewCell.swift
//  MessageKit
//
//  Created by Khristoffer Julio  on 7/14/21.
//

import UIKit
   
open class ReplyCollectionViewCell: MessageContentCell {
    open var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    open var nameLabel = MessageLabel()
    open var messageLabel = MessageLabel()
    open var quoteLabel = MessageLabel()
    
    open var lineDivider: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        return v
    }()
    
    var isFavouritePhoto: Bool = false
    
    open override func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(nameLabel)
        messageContainerView.addSubview(imageView)
        messageContainerView.addSubview(messageLabel)
        messageContainerView.addSubview(quoteLabel)
        messageContainerView.addSubview(lineDivider)
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        imageView.layer.cornerRadius = 12.5 
    }
    
    open func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        lineDivider.translatesAutoresizingMaskIntoConstraints = false
        
        quoteLabel.baselineAdjustment = .alignCenters
        quoteLabel.sizeToFit()
       
        nameLabel.baselineAdjustment = .alignCenters
        nameLabel.sizeToFit()
        
        messageLabel.baselineAdjustment = .alignCenters
        messageLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: messageContainerView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: RSVP_SystemMsgCellPadding),
            nameLabel.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -RSVP_SystemMsgCellPadding),
            
            imageView.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 2),
            imageView.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor, constant: RSVP_SystemMsgCellPadding),
            imageView.heightAnchor.constraint(equalToConstant: 25),
            imageView.widthAnchor.constraint(equalToConstant: 25),
            
            quoteLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            quoteLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: RSVP_SystemMsgCellPadding),
            quoteLabel.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -RSVP_SystemMsgCellPadding),
            
            lineDivider.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 5),
            lineDivider.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor, constant: RSVP_SystemMsgCellPadding),
            lineDivider.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -RSVP_SystemMsgCellPadding),
            lineDivider.heightAnchor.constraint(equalToConstant: 1),
            
            messageLabel.topAnchor.constraint(equalTo: lineDivider.topAnchor, constant: 5),
            messageLabel.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor, constant: RSVP_SystemMsgCellPadding),
            messageLabel.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -RSVP_SystemMsgCellPadding)
        ])
        
        setNeedsLayout()
    }
    
    override open func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError(MessageKitError.nilMessagesDisplayDelegate)
        }
        
        messageLabel.configure {
            isFavouritePhoto = false
            if case .reply(let replyItem) = message.kind {
                nameLabel.attributedText = replyItem.name
                nameLabel.numberOfLines = 1
                
                messageLabel.text = replyItem.message
                messageLabel.numberOfLines = 0
                
                quoteLabel.text = replyItem.quoteMessage
                quoteLabel.numberOfLines = 2
                
                DispatchQueue.main.async {
                    self.setupConstraints()
                }
            }
        }
    }
}

