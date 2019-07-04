//
//  FirstViewController.swift
//  SampleStickersApp
//
//  Created by Sergey Penziy on 7/3/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBAction func onPresent() {
        let callbackEvents: EventHandler<SampleViewController.CallbackEvents> = { events in
            switch events {
            case .back:
                self.navigationController?.popViewController(animated: true)
            }
        }
        let controller = SampleViewController(callbackEvents: callbackEvents)
        self.navigationController?.pushViewController(controller, animated: true)
    }

}
