//
//  UILabel+Ext.swift
//  HB_Bruh
//
//  Created by Ramazan Abdulaev on 15.07.2022.
//

import UIKit

extension UILabel {
    func setTextOrHide(_ text: String?) {
        self.text = text
        isHidden = text == nil || text == ""
    }
}
