//
//  SampleViewController.swift
//  SampleStickersApp
//
//  Created by Sergey Penziy on 7/3/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit
import IDPRootViewGettable
import Stickers

class SampleViewController: UIViewController, RootViewGettable {
    
    typealias RootViewType = SampleView
    
    // MARK: - Initializations and Deallocations
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addImageSticker(_ sender: UIButton) {
        
    }
    
    @IBAction func addTextSticker(_ sender: UIButton) {
        
    }

}
