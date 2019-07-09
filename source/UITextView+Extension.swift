//
//  UITextView+Extension.swift
//  Stickers
//
//  Created by Sergey Penziy on 7/9/19.
//

public extension UITextView {
    
    func updateTextFont(with maxTextViewSize: CGSize, maxFontSize: CGFloat) -> CGSize {
        self.sizeToFit()
        if (self.text.isEmpty || self.bounds.size.equalTo(CGSize.zero)) { return self.frame.size }
        let contentSize = self.contentSize
        let maxHeight = maxTextViewSize.height
        let correctHeight = contentSize.height >= maxHeight ? maxHeight : contentSize.height
        let tempSize = CGSize(width: maxTextViewSize.width, height: correctHeight)
        
        return self.expectSize(maxHeight: maxHeight, maxFontSize: maxFontSize, tempSize: tempSize)
    }
    
    private func expectSize(maxHeight: CGFloat, maxFontSize: CGFloat, tempSize: CGSize) -> CGSize {
        var expectSize = self.sizeThatFits(tempSize)
        guard let startFont = self.font else { return expectSize }
        var expectFont = startFont
        if expectSize.height < maxHeight {
            while expectSize.height < maxHeight, expectFont.pointSize < maxFontSize {
                expectFont = expectFont.withSize(expectFont.pointSize + 1)
                self.font = expectFont
                expectSize = self.sizeThatFits(tempSize)
            }
        }
        if expectSize.height > maxHeight {
            while expectSize.height > maxHeight {
                self.font = expectFont.withSize(expectFont.pointSize - 1)
                expectSize = self.sizeThatFits(tempSize)
            }
        }
        return expectSize
    }
}

