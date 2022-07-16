//
//  QuestsCellModel.swift
//  HB_Bruh
//
//  Created by Ramazan Abdulaev on 15.07.2022.
//

import UIKit

extension QuestsCell {
    
    /// Модель данных, которая приходит извне. И после конфигурирует ячейку
    struct Model {
        let name: String?
        let style: Style
        let isHidden: Bool
    }
    
    /// Стили ячеек
    enum Style {
        case normal
        case success
    }
}
