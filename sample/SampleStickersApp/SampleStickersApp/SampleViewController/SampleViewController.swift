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

typealias EventHandler<Events> = (Events) -> ()

class SampleViewController: UIViewController, RootViewGettable {
    
    typealias RootViewType = SampleView
    
    enum ButtonActions {
        case addImage
        case addText
    }
    
    // MARK: - Initializations and Deallocations
    
    public var actions: EventHandler<ButtonActions>?
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNawBar()
        self.bindActions()
    }
    
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
                print("addImage")
            case  .addText:
                print("addText")
            }
        }
    }
}

extension SampleViewController {
    func configureNawBar() {
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                                      target: self,
                                                                                      action: #selector(self.onBack))
    }
    
    @objc private func onBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
