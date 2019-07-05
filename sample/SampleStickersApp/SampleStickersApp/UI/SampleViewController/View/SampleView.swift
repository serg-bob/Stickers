//
//  SampleView.swift
//  SampleStickersApp
//
//  Created by Sergey Penziy on 7/3/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Stickers

class SampleView: UIView {
    
    @IBOutlet private var stickersView: UIView?
    @IBOutlet private var imageButton: UIButton?
    @IBOutlet private var textButton: UIButton?
    
    var stickerConteinerView: StickersContainerView?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    // MARK: - Private methods

    private func configure() {
        self.stickersView.map {
            self.stickerConteinerView = StickersContainerView(inView: $0)
        }
    }
}
