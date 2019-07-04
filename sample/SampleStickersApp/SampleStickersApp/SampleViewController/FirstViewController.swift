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
        self.navigationController?.pushViewController(SampleViewController(), animated: true)
    }

}
