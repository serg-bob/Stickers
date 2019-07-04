//
//  SampleViewController.swift
//  SampleStickersApp
//
//  Created by Sergey Penziy on 7/3/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit
import Stickers

class SampleViewController: BaseViewController<SampleView, SampleViewController.CallbackEvents> {
    
    enum CallbackEvents {
        case back
    }
    
    enum ButtonActions {
        case addImage
        case addText
    }
    
    // MARK: - Properties
    
    public var actions: EventHandler<ButtonActions>?
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNawBar()
        self.bindActions()
    }
    
    // MARK: - Action
    
    @IBAction func addImageSticker(_ sender: UIButton) {
        self.actions?(.addImage)
    }
    
    @IBAction func addTextSticker(_ sender: UIButton) {
        self.actions?(.addText)
    }
    
    // MARK: - Private methods
    
    private func bindActions() {
        self.actions = { events in
            switch events {
            case .addImage:
                debugPrint("addImage")
            case  .addText:
                debugPrint("addText")
            }
        }
    }
}

// MARK: - Navigation bar methods

extension SampleViewController {
    func configureNawBar() {
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                                      target: self,
                                                                                      action: #selector(self.onBack))
    }
    
    @objc private func onBack() {
        self.callbackEvents(.back)
    }
}
