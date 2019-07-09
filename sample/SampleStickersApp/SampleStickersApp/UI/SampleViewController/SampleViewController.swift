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
        case back
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
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                                      target: self,
                                                                                      action: #selector(self.onBack))
    }
    
    @objc private func onBack() {
        self.callbackEvents(.back)
    }
}
