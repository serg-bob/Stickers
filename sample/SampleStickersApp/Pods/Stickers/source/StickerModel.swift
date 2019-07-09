//
//  StickerModel.swift
//  Stickers
//
//  Created by Sergey Penziy on 7/5/19.
//

public struct StickerModel {
    public enum Content {
        case stickerImage(UIImage)
        case stickerText(String)
    }
    
    public let content: Content
    
    public init(content: Content) {
        self.content = content
    }
}
