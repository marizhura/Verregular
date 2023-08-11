//
//  UIView+Ex.swift
//  Verregular
//
//  Created by Марина Журавлева on 11.08.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
