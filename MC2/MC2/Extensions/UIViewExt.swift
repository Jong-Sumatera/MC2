//
//  UIViewExt.swift
//  MC2
//
//  Created by Widya Limarto on 04/07/22.
//

import Foundation
import UIKit

extension UIView{
    func applyShadow (cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.30
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize (width: 0, height: 5)
    }
}
