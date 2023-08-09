//
//  String+Ex.swift
//  Verregular
//
//  Created by Марина Журавлева on 09.08.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
