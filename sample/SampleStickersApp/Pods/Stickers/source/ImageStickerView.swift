//
//  ImageStickerView.swift
//  Stickers
//
//  Created by Sergey Penziy on 7/5/19.
//

class ImageStickerView: StickerView {
    
    private var imageView: UIImageView?
    
    // MARK: - Public methods
    
    func configure(with image: UIImage) {
        self.append(image)
        self.configure()
    }
    
    // MARK: - Private methods
    
    private func append(_ image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        self.imageView = imageView
        self.appendSubview(imageView)
    }
}
