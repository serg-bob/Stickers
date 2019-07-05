//
//  StickersContainerView.swift
//  Pods-SampleStickersApp
//
//  Created by Sergey Penziy on 7/4/19.
//

import UIKit

public class StickersContainerView: TouchTransparentView {
    
    private var stickers = [StickerView]()
    private var selectedSticker: StickerView?

    // MARK: - Initializations and Deallocations
    
    public init(inView: UIView)  {
        super.init(frame: inView.bounds)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        inView.addSubview(self)
        let views = ["view": self]
        let constraints = ["H:|[view]|", "V:|[view]|"].map {
            NSLayoutConstraint.constraints(withVisualFormat: $0,
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: nil,
                                           views: views)
            }.flatMap{$0}
        inView.addConstraints(constraints)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func append(model: StickerModel) {
        var sticker: StickerView?
        switch model.content {
        case .stickerText(let text):
            sticker = self.createTextSticker(with: text)
        case .stickerImage(let image):
            sticker = self.createImageSticker(with: image)
        }
        sticker.map(self.append)
    }
    
    // MARK: - Private methods
    
    private func createTextSticker(with text: String) -> TextStickerView {
        let textSticker = TextStickerView()
        textSticker.configure(with: text)
        textSticker.startIndex = self.subviews.count
        
        return textSticker
    }
    
    private func createImageSticker(with image: UIImage) -> ImageStickerView {
        let imageSticker = ImageStickerView()
        imageSticker.configure(with: image)
        return imageSticker
    }
    
    private func append(sticker: StickerView) {
        self.createDragGesture(to: sticker)
        self.addSubview(sticker)
        self.stickers.append(sticker)
        if let sticker = sticker as? TextStickerView {
            self.selectedSticker = sticker
            sticker.editText()
        } else {
            sticker.center = self.center
        }
    }
    
    private func createDragGesture(to view: UIView) {
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(self.dragView))
        view.addGestureRecognizer(dragGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.editStickerWithText))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func drag(view: UIView, gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let point = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        view.center = point
        gesture.setTranslation(CGPoint.zero, in: self)
        let sticker = self.stickers.filter({ $0 == view }).first as? TextStickerView
        sticker?.savedCenter = point
        self.selectedSticker = sticker
    }
    
    // MARK: - Objc methods
    
    @objc private func editStickerWithText(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }
        if let sticker = self.stickers.filter({ $0 == view }).first as? TextStickerView {
            self.selectedSticker = sticker
            self.bringSubviewToFront(sticker)
            sticker.editText()
        }
    }
    
    @objc private func dragView(_ gesture: UIPanGestureRecognizer) {
        if gesture.numberOfTouches <= 1, let view = gesture.view {
            if let view = view as? TextStickerView, view.isEditing { return }
            self.drag(view: view, gesture: gesture)
        }
    }
}
