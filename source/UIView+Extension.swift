//
//  UIView+Extension.swift
//  Stickers
//
//  Created by Sergey Penziy on 7/9/19.
//

public extension UIView {
    
    var topSafeAreaHeight: CGFloat {
        return self.safeAreaLayoutGuide.layoutFrame.origin.y
    }
    
    func append(to view: UIView)  {
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
    
    func performAnimation(duration: TimeInterval = 0.2,
                          block: @escaping () -> Void,
                          completion: (() -> Void)? = nil)
    {
        block()
        UIView.animate(withDuration: duration,
                       animations: { self.layoutIfNeeded() },
                       completion: { if $0 { completion?() }
        })
    }
}
