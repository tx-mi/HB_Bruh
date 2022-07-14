//
//  UINavigationController+Ext.swift
//  HB_Bruh
//
//  Created by Ramazan Abdulaev on 15.07.2022.
//

import UIKit

extension UINavigationController {
    func setTitle(with color: UIColor) {
        navigationBar.titleTextAttributes = [.foregroundColor: color]
   }
}
