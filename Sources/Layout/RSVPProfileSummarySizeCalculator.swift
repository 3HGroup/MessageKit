//
//  RSVPProfileSummarySizeCalculator.swift
//  MessageKit
//
//  Created by Liyu Wang on 12/11/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import Foundation

open class RSVPProfileSummarySizeCalculator: TextMessageSizeCalculator {
    open override func messageContainerSize(for message: MessageType) -> CGSize {
        let maxWidth = messageContainerMaxWidth(for: message)
        let messageInsets = messageLabelInsets(for: message)
        let attributedTitleText: NSAttributedString
        let attributedSummaryText: NSAttributedString
        
        // we only limit 2 line description
        let maxLineHeight: CGFloat = {
            let attribute: [NSAttributedString.Key : Any]? = [.font: UIFont.systemFont(ofSize: 13)]
            let msgSize = labelSize(for: NSAttributedString(string: "one liner text", attributes: attribute), considering: maxWidth)
            return msgSize.height * 2
        }()
        
        var messageContainerSize: CGSize
        var bioTextHeight: CGFloat = 0
        
        switch message.kind {
        case .rsvpProfileSummary(let summary):
            attributedTitleText = NSAttributedString(string: summary.title, attributes: [.font: UIFont.systemFont(ofSize: 15)])
            if let summary = summary.text, summary.replacingOccurrences(of: " ", with: "") != "" {
                attributedSummaryText = NSAttributedString(string: summary, attributes: [.font: UIFont.systemFont(ofSize: 13)])
                bioTextHeight = labelSize(for: attributedSummaryText, considering: maxWidth).height
            }
        default:
            fatalError("messageContainerSize received unhandled MessageDataType: \(message.kind)")
        }
        
        messageContainerSize = labelSize(for: attributedTitleText, considering: maxWidth)
        messageContainerSize.width = super.messageContainerMaxWidth(for: message)
        messageContainerSize.height += messageInsets.vertical
        
        // add padding to title label
        messageContainerSize.height += (RSVP_SystemMsgCellPadding + RSVP_SystemMsgCellPadding)
        
        let maxHeight: CGFloat = maxLineHeight
        if bioTextHeight > 0 {
            messageContainerSize.height += bioTextHeight > maxHeight ? maxHeight : bioTextHeight
        }
        
        return messageContainerSize
    }
}
