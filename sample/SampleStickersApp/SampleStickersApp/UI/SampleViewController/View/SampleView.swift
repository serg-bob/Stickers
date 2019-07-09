//
//  SampleView.swift
//  SampleStickersApp
//
//  Created by Sergey Penziy on 7/3/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit

import Stickers

class SampleView: UIView {
    
    enum ButtonActions {
        case addImage
        case addText
    }
    
    @IBOutlet private var stickersView: UIView?
    @IBOutlet private var imageButton: UIButton?
    @IBOutlet private var textButton: UIButton?
    
    var stickerConteinerView: StickersContainerView?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    
    
    // MARK: - Action
    
    @IBAction func addImageSticker(_ sender: UIButton) {
        self.actions(.addImage)
    }
    
    @IBAction func addTextSticker(_ sender: UIButton) {
        self.actions(.addText)
    }
    
    // MARK: - Private methods
    
    private func actions(_ events: ButtonActions) {
        var model: StickerModel?
        switch events {
        case .addImage:
            UIImage(named: "diamond").map {
                model = StickerModel(content: .stickerImage($0))
            }
        case  .addText:
            model = StickerModel(content: .stickerText(""))
        }
        model.map {
            self.stickerConteinerView?.append(model: $0)
        }
    }

    private func configure() {
        self.stickersView.map {
            self.stickerConteinerView = StickersContainerView(inView: $0)
        }
    }
}
