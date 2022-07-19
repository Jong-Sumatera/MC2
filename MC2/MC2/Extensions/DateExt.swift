//
//  DateExt.swift
//  MC2
//
//  Created by Widya Limarto on 19/07/22.
//

import Foundation


extension Date {
    
    var formattedDate : String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd MMM yy"
        return dateformatter.string(from: self)
    }
}
