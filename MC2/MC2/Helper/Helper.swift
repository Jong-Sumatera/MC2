//
//  Helper.swift
//  MC2
//
//  Created by Widya Limarto on 22/07/22.
//

import Foundation

class Helper {
    static func tagsToString(tags: [TagViewModel]) -> String {
        var text = ""
        if tags.count > 0 {
            for tag in tags {
                text += " [\(tag.title)](s://tag/\(tag.title))"
            }
        }
        return text
    }
}
