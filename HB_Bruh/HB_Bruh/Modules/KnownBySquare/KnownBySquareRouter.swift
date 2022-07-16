//
//  KnownBySquareRouter.swift
//  HB_Bruh
//
//  Created by Ramazan Abdulaev on 16.07.2022.
//

import UIKit

protocol KnownBySquareRouterProtocol: AnyObject {
    init(view: UIViewController)
}

final class KnownBySquareRouter: KnownBySquareRouterProtocol {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
}
