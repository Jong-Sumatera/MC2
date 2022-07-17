//
//  Translation+Extensions.swift
//  MC2
//
//  Created by Widya Limarto on 17/07/22.
//

import Foundation

extension Translation: BaseModel {
    static func findByText(text: String) -> Translation? {
        let res = Translation.findBy(format: "text == %@", text)
        if res.count > 0 {
            return res[0] as? Translation
        } else {
            return nil
        }
    }
}
