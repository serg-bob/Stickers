//
//  TextStickerBackgroundView.swift
//  Stickers
//
//  Created by Sergey Penziy on 7/9/19.
//

protocol TextStickerBackgroundViewDelegate {
    func backgroundViewDidClose(_ view: TextStickerBackgroundView)
}

class TextStickerBackgroundView: UIView {
    
    private(set) var closeButton: UIButton?
    
    let closeButtonFrame = CGRect(origin: CGPoint(x: 0, y: 25),
                                  size: CGSize(width: 30, height: 30))
    
    var delegate: TextStickerBackgroundViewDelegate?
    
    // MARK: - Initializations and Deallocations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        self.backgroundColor = .clear
        self.createDarkBackgroundView()
        self.createCloseButton()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideBackgroundView))
        self.addGestureRecognizer(tapGesture)
    }
    
    private func createDarkBackgroundView() {
        let darkBackgroundView = UIView(frame: self.frame)
        darkBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        darkBackgroundView.append(to: self)
    }
    
    private func createCloseButton() {
        let closeButton = UIButton(frame: CGRect(origin: CGPoint(x: 16, y: self.topSafeAreaHeight), size: CGSize(width: 30, height: 30)))
        closeButton.setImage(UIImage(named: "select_button"), for: .normal)
        closeButton.addTarget(self, action: #selector(self.hideBackgroundView), for: .touchUpInside)
        self.addSubview(closeButton)
    }
    
    @objc private func hideBackgroundView() {
        self.removeFromSuperview()
        self.delegate?.backgroundViewDidClose(self)
    }
}
