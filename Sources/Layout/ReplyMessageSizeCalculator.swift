//
//  ReplyMessageSizeCalculator.swift
//  MessageKit
//
//  Created by Khristoffer Julio  on 7/15/21.
//

import Foundation

open class ReplyMessageSizeCalculator: MessageSizeCalculator {
    public var incomingMessageLabelInsets = UIEdgeInsets(top: 7, left: 18, bottom: 7, right: 14)
    public var outgoingMessageLabelInsets = UIEdgeInsets(top: 7, left: 14, bottom: 7, right: 18)
    
    public var messageLabelFont = UIFont(name: "AvenirNext-Regular", size: 15)!
    
    internal func messageLabelInsets(for message: MessageType) -> UIEdgeInsets {
        let dataSource = messagesLayout.messagesDataSource
        let isFromCurrentSender = dataSource.isFromCurrentSender(message: message)
        return isFromCurrentSender ? outgoingMessageLabelInsets : incomingMessageLabelInsets
    }
    
    open override func messageContainerMaxWidth(for message: MessageType) -> CGFloat {
        let maxWidth = super.messageContainerMaxWidth(for: message)
        let textInsets = messageLabelInsets(for: message)
        return maxWidth - textInsets.horizontal
    }
    
    open override func messageContainerSize(for message: MessageType) -> CGSize {
        var messageContainerSize: CGSize
        let attributedText: NSAttributedString
        
        switch message.kind {
        case .reply(let item):
            let quoteMessageLimited = item.quoteMessage.prefix(40)
            let string = "\(item.name.string)\n\(quoteMessageLimited)\n\(item.message)"
            attributedText = NSAttributedString(string: string, attributes: [.font: messageLabelFont ])
            
        default:
            fatalError("messageContainerSize received unhandled MessageDataType: \(message.kind)")
        }
        
        let maxWidth = messageContainerMaxWidth(for: message)
        messageContainerSize = labelSize(for: attributedText, considering: maxWidth)
 
        let messageInsets = messageLabelInsets(for: message)
        let avatarWidth: CGFloat = 40
        let topBottomPadding: CGFloat = 10
        messageContainerSize.width += messageInsets.horizontal + avatarWidth
        messageContainerSize.height += messageInsets.vertical + topBottomPadding
                
        return messageContainerSize
    }
}
