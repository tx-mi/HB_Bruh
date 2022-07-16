//
//  QuestsRouter.swift
//  HB_Bruh
//
//  Created by Ramazan Abdulaev on 15.07.2022.
//

import UIKit

protocol QuestsRouterProtocol {
    init(view: UIViewController)
    func moveToQuest(at: Screens) // Here will be transition to some quest
}

final class QuestsRouter: QuestsRouterProtocol {
    
    // MARK: - Properties

    private weak var view: UIViewController?
    
    // MARK: - Initializers

    init(view: UIViewController) {
        self.view = view
    }
    
    // MARK: - Methods

    func moveToQuest(at screen: Screens) {
        guard let view = view, let navigationController = view.navigationController else { return }
        var viewController: UIViewController
        switch screen {
        case .knownBySquare:
            viewController = UIViewController()
        case .bookCode:
            viewController = UIViewController()
        case .crossword:
            viewController = UIViewController()
        case .memoryGame:
            viewController = UIViewController()
        case .solomonTreasure:
            viewController = UIViewController()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}

