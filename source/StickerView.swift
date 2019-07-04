//
//  StickerView.swift
//  IDPCastable
//
//  Created by Sergey Penziy on 7/3/19.
//

class StickerView: UIView {
    
    private(set) var savedScale: CGFloat = 1.0
    private(set) var tempRotation: CGFloat = 0.0
    private(set) var scale: CGFloat = 1.0
    private(set) var angle: CGFloat = 0.0
    
    // MARK: - Override methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.savedScale = self.scaleX
        self.tempRotation = 0
    }
    
    // MARK: - Public methods
    
    func configure() {
        self.isMultipleTouchEnabled = true
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.transform = CGAffineTransform.identity
        self.scale = self.scaleX
        self.angle = self.rotation
        self.appendGestures()
    }
    
    func appendSubview(_ view: UIView) {
        self.addSubview(view)
        self.frame = view.frame
        self.appendConstraints(to: view)
    }
    
    func updateTransform(with translationOfset: CGPoint = CGPoint.zero, angle: CGFloat, scale: CGFloat) {
        self.transform = CGAffineTransform(translationX: translationOfset.x, y: translationOfset.y)
        self.transform = self.transform.rotated(by: angle)
        self.transform = self.transform.scaledBy(x: scale, y: scale)
    }
    
    // MARK: - Private methods
    
    private func appendConstraints(to view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let views = ["view": view]
        let constraints = ["H:|[view]|", "V:|[view]|"].map {
            NSLayoutConstraint.constraints(withVisualFormat: $0,
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: nil,
                                           views: views)
            }.flatMap{$0}
        self.addConstraints(constraints)
    }
    
    private func appendGestures() {
        let roation = UIRotationGestureRecognizer(target: self, action: #selector(self.handleRotation))
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinch))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan))
        [roation, pinch, pan].forEach {
            $0.delegate = self
            self.addGestureRecognizer($0)
        }
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard gesture.numberOfTouches >= 2 else { return }
        let translation = gesture.translation(in: self.superview)
        self.updateTransform(with: translation, angle: self.angle, scale: self.scale)
    }
    
    @objc private func handleRotation(_ gesture: UIRotationGestureRecognizer) {
        guard gesture.numberOfTouches >= 2 else { return }
        let rotate = gesture.rotation - self.tempRotation
        self.tempRotation = gesture.rotation
        self.angle += rotate
        self.updateTransform(angle: self.angle, scale: self.scale)
    }
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard gesture.numberOfTouches >= 2 else { return }
        self.scale = gesture.scale * self.savedScale
        self.updateTransform(angle: self.angle, scale: self.scale)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension StickerView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension StickerView {
    var scaleX: CGFloat {
        let transform = self.transform
        return sqrt(pow(transform.a, 2) + pow(transform.c, 2))
    }
    
    var scaleY: CGFloat {
        let transform = self.transform
        return sqrt(pow(transform.b, 2) + pow(transform.d, 2))
    }
    
    var rotation: CGFloat {
        let transform = self.transform
        let a = Float(transform.a)
        let b = Float(transform.b)
        return CGFloat(atan2f(b, a))
    }
}
