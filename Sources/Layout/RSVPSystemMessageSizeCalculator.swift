//
//  RSVPSystemMessageSizeCalculator.swift
//  MessageKit
//
//  Created by Liyu Wang on 15/10/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import Foundation

open class RSVPSystemMessageSizeCalculator: TextMessageSizeCalculator {
    
    open override func messageContainerMaxWidth(for message: MessageType) -> CGFloat {
        let maxWidth = super.messageContainerMaxWidth(for: message)
        
        var iconWidth: CGFloat = 0
        if case .rsvpSystem(let systemItem) = message.kind {
            switch systemItem.style {
            case .favorite, .tag, .encrypted:
                iconWidth = RSVP_SystemMsgCellIconSize
            default:
                iconWidth = 0
            }
        }
        return maxWidth - (iconWidth + 2 * RSVP_SystemMsgCellPadding + RSVP_SystemMsgCellPadding)
    }
    
    open override func messageContainerSize(for message: MessageType) -> CGSize {
        let maxWidth = messageContainerMaxWidth(for: message)
        
        var messageContainerSize: CGSize
        let attributedText: NSAttributedString
        
        var iconWidth: CGFloat = 0
        
        switch message.kind {
            
        case .rsvpSystem(let systemItem):
            attributedText = NSAttributedString(string: systemItem.attributedText.string,
                                                attributes: [.font: UIFont.systemFont(ofSize: 17)])
            
            switch systemItem.style {
            case .sysDefault, .historyDeleted:
                iconWidth = 0
            case .favorite, .tag, .encrypted:
                iconWidth = RSVP_SystemMsgCellIconSize
            }
        default:
            fatalError("messageContainerSize received unhandled MessageDataType: \(message.kind)")
        }
        
        messageContainerSize = labelSize(for: attributedText, considering: maxWidth)
        // important: strictly reset the width to maxwidth
        messageContainerSize = CGSize(width: maxWidth, height: messageContainerSize.height)
        
        let messageInsets = messageLabelInsets(for: message)
        messageContainerSize.width += messageInsets.horizontal
        messageContainerSize.height += messageInsets.vertical
        
        messageContainerSize.width += (iconWidth + 2 * RSVP_SystemMsgCellPadding + RSVP_SystemMsgCellPadding)
        messageContainerSize.height += (RSVP_SystemMsgCellPadding + RSVP_SystemMsgCellPadding)
        
        return messageContainerSize
    }
}
