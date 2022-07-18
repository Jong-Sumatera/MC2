//
//  UIColorExt.swift
//  MC2
//
//  Created by Widya Limarto on 04/07/22.
//

import Foundation
import UIKit

extension UIColor {

     class func color(data:Data) -> UIColor? {
          return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
     }

     func encode() -> Data? {
          return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
     }
}


