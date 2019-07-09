//
//  UIView+Extension.swift
//  Stickers
//
//  Created by Sergey Penziy on 7/9/19.
//

extension UIView {
    
    public var topSafeAreaHeight: CGFloat {
        return self.safeAreaLayoutGuide.layoutFrame.origin.y
    }
    
    public func append(to view: UIView)  {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        let views = ["view": self]
        let constraints = ["H:|[view]|", "V:|[view]|"].map {
            NSLayoutConstraint.constraints(withVisualFormat: $0,
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: nil,
                                           views: views)
            }.flatMap{$0}
        view.addConstraints(constraints)
    }
    
    public func performAnimation(duration: TimeInterval = 0.2,
                          block: @escaping () -> Void,
                          completion: (() -> Void)? = nil)
    {
        block()
        UIView.animate(withDuration: duration,
                       animations: { self.layoutIfNeeded() },
                       completion: { if $0 { completion?() }
        })
    }
    
    public func imageSnapshot(renderer: UIGraphicsImageRenderer? = nil) -> UIImage {
        let resultSize = self.bounds.size
        let resultRect = CGRect(origin: CGPoint.zero, size: resultSize)
        let renderer = renderer ?? UIGraphicsImageRenderer.defaultSnapshotRenderer(with: self)
        return renderer.image { rendererContext in
            self.drawHierarchy(in: resultRect, afterScreenUpdates: false)
        }
    }
}
