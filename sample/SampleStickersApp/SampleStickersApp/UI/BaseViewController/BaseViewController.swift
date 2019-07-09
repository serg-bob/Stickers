//
//  BaseViewController.swift
//  SampleStickersApp
//
//  Created by Sergey Penziy on 7/4/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit

public typealias EventHandler<Events> = (Events) -> ()

class BaseViewController<RootViewType: UIView, Events>: UIViewController {

    public let callbackEvents: EventHandler<Events>
    public var rootView: RootViewType? {
        return self.viewIfLoaded as? RootViewType
    }
    
    // MARK: - Initializations and Deallocations
    
    deinit {
        debugPrint("deinit: \(String(describing: type(of: self)))")
    }
    
    init(callbackEvents: @escaping EventHandler<Events>) {
        self.callbackEvents = callbackEvents
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
