//
//  TextStickerView.swift
//  Stickers
//
//  Created by Sergey Penziy on 7/5/19.
//

class TextStickerView: StickerView, UITextViewDelegate {
    
    private var textView: ResizableTextView?
    private var presentViewFrame = CGRect.zero
    private var settings = TextViewSettings.default()
    
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
    
    func configure(with text: String, settings: TextViewSettings = .default()) {
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
        let textView = ResizableTextView()
        textView.configure(with: self.settings)
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
