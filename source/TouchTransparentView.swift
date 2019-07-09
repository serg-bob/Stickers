//
//  TouchTransparentView.swift
//  Stickers
//
//  Created by Sergey Penziy on 7/5/19.
//

public class TouchTransparentView: UIView {
    
    public var isTouchTransparent: Bool = true
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        return self.isTouchTransparent ? hitView == self ? nil : hitView : hitView
    }
}
