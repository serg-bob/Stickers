//
//  ResizableTextView.swift
//  Stickers
//
//  Created by Sergey Penziy on 7/5/19.
//

struct TextViewSettings {
    let font: UIFont
    let textColor: UIColor
    let backgroundColor: UIColor
    
    static func `default`() -> TextViewSettings {
        return TextViewSettings(font: UIFont.boldSystemFont(ofSize: 33),
                                textColor: UIColor.black,
                                backgroundColor: UIColor.clear)
    }
}

class ResizableTextView: UITextView {
    
    // MARK: - Public methods
    
    func configure(with settings: TextViewSettings) {
        self.font = settings.font
        self.textColor = settings.textColor
        self.backgroundColor = settings.backgroundColor
        self.textAlignment = .center
        self.isScrollEnabled = false
        self.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
    }
    
    func endEditing() {
        self.resignFirstResponder()
        self.endEditing(true)
    }
    
    func updateText(color: UIColor) {
        self.textColor = color
    }
}
