//
//  SampleViewController.swift
//  SampleStickersApp
//
//  Created by Sergey Penziy on 7/3/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit

class SampleViewController: BaseViewController<SampleView, SampleViewController.CallbackEvents> {
    
    enum CallbackEvents {
        case back(UIImage?)
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNawBar()
    }
}

// MARK: - Navigation bar methods

extension SampleViewController {
    func configureNawBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                target: self,
                                                                action: #selector(self.onBack))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(self.onSave))
    }
    
    @objc private func onBack() {
        self.callbackEvents(.back(nil))
    }
    
    @objc private func onSave() {
        let image = self.rootView?.stickerConteinerView?.getImageWithStickers()
        self.callbackEvents(.back(image))
    }
}
