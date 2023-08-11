//
//  Verb.swift
//  MVCLesson
//
//  Created by Марина Журавлева on 01.08.2023.
//

import Foundation

struct Verb {
    let infinitive: String
    let pastSimple: String
    let participle: String
    var translation: String
    
    {
        NSLocalizedString(self.infinitive, comment: "")
    }
}

