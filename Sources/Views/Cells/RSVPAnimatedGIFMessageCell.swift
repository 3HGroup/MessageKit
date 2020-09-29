//
//  RSVPGifMessageCell.swift
//  MessageKit
//
//  Created by Liyu Wang on 29/11/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import UIKit
import FLAnimatedImage

let logoImageViewHeight: CGFloat = 18

open class RSVPAnimatedGIFMessageCell: MessageContentCell {
    /// The image view display the media content.
    open var imageView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
        return imageView
    }()
    
    var waterMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.black//UIColor.white.withAlphaComponent(0.7)
        return imageView
    }()
    
    // MARK: - Methods
    
    /// Responsible for setting up the constraints of the cell's subviews.
    open func setupConstraints() {
        imageView.addConstraints(self.messageContainerView.topAnchor,
                                 left: self.messageContainerView.leftAnchor,
                                 bottom: self.messageContainerView.bottomAnchor,
                                 right: self.messageContainerView.rightAnchor,
                                 bottomConstant: logoImageViewHeight)
        
        waterMarkImageView.addConstraints(nil,
                                left: self.messageContainerView.leftAnchor,
                                bottom: self.messageContainerView.bottomAnchor,
                                right: self.messageContainerView.rightAnchor,
                                heightConstant: logoImageViewHeight)
    }
    
    open override func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(imageView)
        messageContainerView.addSubview(waterMarkImageView)
        setupConstraints()
    }
    
    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError(MessageKitError.nilMessagesDisplayDelegate)
        }
        
        switch message.kind {
        case .gif(let mediaItem):
            imageView.image = mediaItem.image ?? mediaItem.placeholderImage
            let assetBundle = Bundle.messageKitAssetBundle()
            let imagePath = assetBundle.path(forResource: "powered_by_giphy_dark", ofType: "png", inDirectory: "Images")
            let image = UIImage(contentsOfFile: imagePath!)
            waterMarkImageView.image = image
        default:
            break
        }
        
        displayDelegate.configureMediaMessageImageView(imageView, for: message, at: indexPath, in: messagesCollectionView)
    }
}
