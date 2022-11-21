//
//  LocalizeExtension.swift
//  StopSmoke
//
//  Created by Marat on 21.11.2022.
//

import Foundation

extension String {
    func localize(from tableName: String) -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: Bundle.main, value: "", comment: "")
    }
}
