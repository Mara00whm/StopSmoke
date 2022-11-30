//
//  UserDefaultsManager.swift
//  StopSmoke
//
//  Created by Marat on 01.12.2022.
//

import Foundation

protocol UserDefaultsProtocol {
  func storeId(_ value: Bool)
  func readId() -> Bool?
}

class UserDefaultsManager: UserDefaultsProtocol {
  
  private let storage = UserDefaults.standard
    private let key: String = "isFirstOpening"
    
    
  func storeId(_ value: Bool) {
    storage.set(value, forKey: key)
  }
  
  func readId() -> Bool? {
    storage.bool(forKey: key)
  }
}
