//
//  TextStickerView.swift
//  Pods-SampleStickersApp
//
//  Created by Sergey Penziy on 7/5/19.
//

class TextStickerView: StickerView, UITextViewDelegate {
    
    private let maxTextCount = 200
    private var textView: ResizableTextView?
    private var presentViewFrame = CGRect.zero
    
    private(set) var isEditing = false
    
    var savedCenter: CGPoint?
    var startIndex: Int = 0
    var savedColorPosition: CGPoint?
    
    var isEmpty: Bool {
        get {
            return self.textView?.text.isEmpty ?? true
        }
    }
    
    // MARK: - Public methods
    
    func configure(with text: String) {
        self.append(text)
        self.configure()
    }
    
    func editText() {
        self.isEditing = true
        self.textView?.isUserInteractionEnabled = true
        self.textView?.becomeFirstResponder()
    }
    
    func endEditing() {
        self.isEditing = false
        self.textView?.isUserInteractionEnabled = false
        self.textView?.endEditing()
    }
    
    func updateSize(with presentViewFrame: CGRect, keyboardState: KeyboardState) {
        self.presentViewFrame = presentViewFrame
        self.updateTransform(keyboardState: keyboardState)
    }
    
    func update(color: UIColor, position: CGPoint) {
        self.textView?.updateText(color: color)
        self.savedColorPosition = position
    }
    
    // MARK: - Private methods
    
    private func append(_ text: String) {
        let settings = TextViewSettings.default()
        let textView = ResizableTextView()
        textView.configure(with: settings)
        textView.delegate = self
        self.textView = textView
        self.appendSubview(textView)
    }
    
    private func updateTransform(keyboardState: KeyboardState) {
        switch keyboardState {
        case .showKeyboard:
            self.updateTransform(angle: 0, scale: 1)
            self.setCenter()
        case .hideKeyboard:
            self.updateTransform(angle: self.angle, scale: self.scale)
        }
    }
    
    private func setCenter() {
        let presentViewFrame = self.presentViewFrame
        self.center = CGPoint(x: presentViewFrame.width / 2,
                              y: (presentViewFrame.height / 2) + presentViewFrame.origin.y)
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        textView.becomeFirstResponder()
        let settings = TextViewSettings.default()
        let newSize = textView.updateTextFont(with: self.presentViewFrame.size, maxFontSize: settings.font.pointSize)
        self.frame.size = newSize
        self.setCenter()
    }
}

fileprivate extension UITextView {
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
                expectFont = expectFont.withSize(expectFont.pointSize - 1)
                self.font = expectFont
                expectSize = self.sizeThatFits(tempSize)
            }
        }
        return expectSize
    }
}
