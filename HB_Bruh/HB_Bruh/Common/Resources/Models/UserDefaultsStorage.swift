//
//  UserDefaultsStorage.swift
//  HB_Bruh
//
//  Created by Ramazan Abdulaev on 16.07.2022.
//

import Foundation

protocol UserDefaultsStorage {
    var isSecondOpen: Bool { get set }
}

extension UserDefaults: UserDefaultsStorage {
    private static var isSecondOpenKey = "HB_Bruh.is_second_open"
    
    var isSecondOpen: Bool {
        get {
            bool(forKey: Self.isSecondOpenKey)
        }
        set {
            set(newValue, forKey: Self.isSecondOpenKey)
        }
    }
}
