//
//  BaseRouter.swift
//  Roscom
//
//  Created by Jaap Manenschijn on 19/09/2019.
//  Copyright © 2019 Move4Mobile. All rights reserved.
//

import Foundation
import UIKit

enum RouterPresentationType {
    case push
    case present
}

class BaseRouter {
    
    // Weak link to viewController so the router and viewcontroller won't have a retain cycle
    weak var source: UIViewController?
    
    init(source: UIViewController?) {
        self.source = source
    }
    
    func navigate(_ destination: UIViewController?, _ presentationType: RouterPresentationType, animated: Bool = true) {
        if let vc = destination {
            switch presentationType {
            case .present:
                //Presents the new view controller
                source?.present(vc, animated: animated, completion: nil)
            case .push:
                //Pushes the new view controller
                source?.navigationController?.pushViewController(vc, animated: animated)
            }
        }
    }
    
    func navigateBack(_ presentationType: RouterPresentationType, animated: Bool = true) {
        switch presentationType {
        case .present:
            source?.dismiss(animated: animated)
        case .push:
            source?.navigationController?.popViewController(animated: animated)
        }
    }
}
