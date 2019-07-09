//
//  StickersContainerView.swift
//  Stickers
//
//  Created by Sergey Penziy on 7/4/19.
//

public class StickersContainerView: TouchTransparentView {
    
    private var stickers = [StickerView]()
    private var selectedSticker: StickerView?
    private var backgroundView: TextStickerBackgroundView?
    
    private let keyboardNotifications = KeyboardNotifications()

    // MARK: - Initializations and Deallocations
    
    public init(inView: UIView)  {
        super.init(frame: inView.bounds)
        self.append(to: inView)
        self.createBackgroundView()
        self.bindKeyboardNotifications()
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
    
    public func getImageWithStickers() -> UIImage {
        return self.imageSnapshot()
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
    
    private func createBackgroundView() {
        let view = TextStickerBackgroundView(frame: UIScreen.main.bounds)
        view.delegate = self
        self.backgroundView = view
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
    
    private func bindKeyboardNotifications() {
        self.keyboardNotifications.animatingParameters = { [weak self] (keyboardState, endFrame, duration) in
            self?.updateView(with: (keyboardState, endFrame, duration))
        }
    }
    
    func updateView(with keyboardParameters: (KeyboardState, CGRect, Double)) {
        let (keyboardState, keyboardFrame, duration) = keyboardParameters
        if let backgroundView = self.backgroundView, let sticker = self.selectedSticker as? TextStickerView {
            switch keyboardState {
            case .showKeyboard:
                self.insertSubview(backgroundView, belowSubview: sticker)
            case .hideKeyboard:
                if sticker.isEmpty {
                    self.remove(sticker: sticker)
                } else {
                    self.insertSubview(sticker, at: sticker.startIndex)
                }
            }
            let closeButtonFrame = backgroundView.closeButtonFrame
            let yPosition = closeButtonFrame.origin.y + closeButtonFrame.size.height + self.topSafeAreaHeight
            let presentViewFrame = CGRect(origin: CGPoint(x: 0, y: yPosition),
                                          size: CGSize(width: self.frame.size.width,
                                                       height: self.frame.size.height - keyboardFrame.size.height - yPosition))
            sticker.updateSize(with: presentViewFrame, keyboardState: keyboardState)
            self.performAnimation(duration: duration, block: { [weak self] in
                self?.setStickerCenter(height: keyboardFrame.size.height, keyboardState: keyboardState)
            })
        }
    }
    
    private func setStickerCenter(height: CGFloat, keyboardState: KeyboardState) {
        switch keyboardState {
        case .showKeyboard:
            return
        case .hideKeyboard:
            guard let savedCenter = (self.selectedSticker as? TextStickerView)?.savedCenter else { return }
            self.selectedSticker?.center = savedCenter
        }
    }
    
    private func remove(sticker: StickerView) {
        self.stickers.firstIndex(of: sticker)
            .map { self.stickers.remove(at: $0) }?
            .removeFromSuperview()
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

// MARK: - EditMomentBackgroundViewDelegate

extension StickersContainerView: TextStickerBackgroundViewDelegate {
    func backgroundViewDidClose(_ view: TextStickerBackgroundView) {
        (self.selectedSticker as? TextStickerView)?.endEditing()
    }
}
