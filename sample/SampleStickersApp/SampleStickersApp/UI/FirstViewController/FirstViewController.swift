//
//  FirstViewController.swift
//  SampleStickersApp
//
//  Created by Sergey Penziy on 7/3/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController<FirstView, FirstViewController.EmptyEvents> {
    
    enum EmptyEvents {
        case none
    }
    
    // MARK: - Action

    @IBAction func onPresent() {
        let controller = SampleViewController(callbackEvents: self.callback)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Private methods
    
    private func callback(_ events: SampleViewController.CallbackEvents) {
        switch events {
        case .back(let image):
            self.rootView?.imageView?.image = image
            self.navigationController?.popViewController(animated: true)
        }
    }
}
