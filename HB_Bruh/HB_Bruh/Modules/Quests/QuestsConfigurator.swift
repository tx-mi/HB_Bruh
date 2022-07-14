//
//  QuestsConfigurator.swift
//  HB_Bruh
//
//  Created by Ramazan Abdulaev on 15.07.2022.
//

import UIKit

final class QuestsConfigurator {
    
    static func configure() -> UIViewController {
        let view = QuestsVC(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: view)
        let router = QuestsRouter(view: view)
        let presenter = QuestsPresenter(view: view, router: router)
        view.presenter = presenter
        
        return navigationController
    }
    
}
