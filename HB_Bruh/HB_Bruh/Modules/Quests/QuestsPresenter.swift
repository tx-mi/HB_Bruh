//
//  QuestsPresenter.swift
//  HB_Bruh
//
//  Created by Ramazan Abdulaev on 15.07.2022.
//

import UIKit

protocol QuestsViewOutput: AnyObject {
    init(view: QuestsViewInput, router: QuestsRouterProtocol, userDefaults: UserDefaultsStorage)
    func moveToQuest(at: Screens) // call same func in router
}

final class QuestsPresenter: NSObject, QuestsViewOutput {
    
    // MARK: - Properties
    
    private weak var view: QuestsViewInput?
    private let router: QuestsRouterProtocol
    private var quests: [Quest] = [Quest]()
    private var userDefaults: UserDefaultsStorage
    
    // MARK: - Initializers
    
    init(
        view: QuestsViewInput,
        router: QuestsRouterProtocol,
        userDefaults: UserDefaultsStorage
    ) {
        self.view = view
        self.router = router
        self.userDefaults = userDefaults
        super.init()
        configureQuests()
    }
    
    // MARK: - Methods
    
    func moveToQuest(at screen: Screens) {
        router.moveToQuest(at: screen)
    }
    
    func configureQuests() {
        guard !userDefaults.isSecondOpen else {
            quests = Quest().fetchQuests()
            return
        }
        userDefaults.isSecondOpen = true
        quests = Quest().makeQuests()
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
        
        let quest = quests[indexPath.row]
        let isHidden: Bool = {
            guard indexPath.row != 0 else { return false }
            let prevQuest = quests[indexPath.row - 1]
            return prevQuest.isCompleted ? false : true
        }()
        
        cell.configure(with: .init(quest, isHidden))
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

// MARK: - QuestsCell.Model

private extension QuestsCell.Model {
    init(_ model: Quest, _ isHidden: Bool) {
        self.name = model.name
        style = model.isCompleted ? .success : .normal
        self.isHidden = isHidden
    }
}
