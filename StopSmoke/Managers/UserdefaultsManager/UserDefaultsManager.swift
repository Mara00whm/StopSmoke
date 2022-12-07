//
//  UserDefaultsManager.swift
//  StopSmoke
//
//  Created by Marat on 01.12.2022.
//

import Foundation

protocol UserDefaultsProtocol {
    func storeFirstOpenning(_ value: Bool)
    func readFirstOpenning() -> Bool?
    func storeCigaretteLimit(_ value: Int?)
    func readCigaretteLimit() -> Int?
}

class UserDefaultsManager: UserDefaultsProtocol {
    
    private let storage = UserDefaults.standard
    private let key: String = "isFirstOpening"
    private let limit: String = "limit"
    
    func storeFirstOpenning(_ value: Bool) {
        storage.set(value, forKey: key)
    }
    
    func readFirstOpenning() -> Bool? {
        storage.bool(forKey: key)
    }
    
    func storeCigaretteLimit(_ value: Int?) {
        storage.set(value, forKey: limit)
    }
    func readCigaretteLimit() -> Int? {
         storage.object(forKey: limit) == nil ?  nil : storage.integer(forKey: limit)
    }
}
