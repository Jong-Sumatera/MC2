//
//  SelectionLineViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 17/07/22.
//

import Foundation
import CoreData
import SwiftUI

struct SelectionLineViewModel {
    var selection: SelectionLine
    
    init(id: UUID, bounds: CGRect, page: Int) {
        print(page)
        self.selection = SelectionLine(context: SelectionLine.context)
        self.selection.id = id
        self.selection.x = Double(bounds.origin.x)
        self.selection.y = Double(bounds.origin.y)
        self.selection.width = bounds.width
        self.selection.height = bounds.height
        self.selection.page = Int64(page)
        self.selection.createdDate = Date()
    }
    
    init(selection: SelectionLine) {
        self.selection = selection
    }
    
    var id: NSManagedObjectID {
        return selection.objectID
    }
    
    var selectionId: String {
        return selection.id?.uuidString ?? ""
    }
    
    var bounds: CGRect {
        return CGRect(x: selection.x, y: selection.y, width: selection.width, height: selection.height)
    }
    
    var page: Int {
        return Int(selection.page)
    }
}
