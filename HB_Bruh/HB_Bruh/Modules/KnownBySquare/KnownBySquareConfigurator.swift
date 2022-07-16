//
//  KnownBySquareConfigurator.swift
//  HB_Bruh
//
//  Created by Ramazan Abdulaev on 16.07.2022.
//

import UIKit

final class KnownBySquareConfigurator {
    
    static func configure() -> UIViewController {
        let view = KnownBySquareVC()
        let router = KnownBySquareRouter(view: view)
        let presenter = KnownBySquarePresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
    
}
