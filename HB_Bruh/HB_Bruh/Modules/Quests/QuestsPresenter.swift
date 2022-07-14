//
//  QuestsPresenter.swift
//  HB_Bruh
//
//  Created by Ramazan Abdulaev on 15.07.2022.
//

import UIKit

protocol QuestsViewOutput: AnyObject {
    init(view: QuestsViewInput, router: QuestsRouterProtocol)
    func moveToQuest(at: Screens) // call same func in router
}

final class QuestsPresenter: NSObject, QuestsViewOutput {
    
    // MARK: - Properties
    
    private weak var view: QuestsViewInput?
    private let router: QuestsRouterProtocol
    
    // MARK: - Initializers
    
    init(
        view: QuestsViewInput,
        router: QuestsRouterProtocol
    ) {
        self.view = view
        self.router = router
        super.init()
    }
    
    // MARK: - Methods
    
    func moveToQuest(at screen: Screens) {
        router.moveToQuest(at: screen)
    }
    
}

// MARK: - UICollectionViewDataSource

extension QuestsPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: QuestsCell.reuseId,
            for: indexPath
        ) as? QuestsCell else { return UICollectionViewCell() }
        
        cell.configure(with: .init(name: "Quest \(indexPath.row)"))
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension QuestsPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextScreen = Screens.allCases[indexPath.row]
        moveToQuest(at: nextScreen)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

private extension QuestsCell.Model {
    init(name: String) {
        self.name = name
        style = .normal
        self.isHidden = false
    }
}
