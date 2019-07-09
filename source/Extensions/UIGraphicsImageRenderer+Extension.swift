//
//  UIGraphicsImageRenderer+Extension.swift
//  Pods-SampleStickersApp
//
//  Created by Sergey Penziy on 7/9/19.
//

extension UIGraphicsImageRenderer {
    public static func defaultSnapshotRenderer(with view: UIView) -> UIGraphicsImageRenderer {
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = UIScreen.main.scale
        format.opaque = false
        return UIGraphicsImageRenderer(size: view.frame.size, format: format)
    }
}
