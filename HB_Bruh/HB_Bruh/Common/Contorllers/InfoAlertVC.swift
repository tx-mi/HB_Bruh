//
//  InfoAlertVC.swift
//  HB_Bruh
//
//  Created by Ramazan Abdulaev on 16.07.2022.
//

import UIKit

/// Класс для показа текста с историей
final class InfoAlertVC: UIAlertController {
    convenience init(
        title: String?,
        message: String?
    ) {
        self.init(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "Понял принял обработал",
            style: .default
        )
        addAction(okAction)
    }
}
