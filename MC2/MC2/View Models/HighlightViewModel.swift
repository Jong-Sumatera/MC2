//
//  HighlightViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 17/07/22.
//

import Foundation
import CoreData
import UIKit
import SwiftUI

struct HighlightViewModel: Hashable {
    var highlight: Highlight
    
    init(highlight: Highlight){
        self.highlight = highlight
    }
    
    var id: NSManagedObjectID {
        return highlight.objectID
    }
    
    var highlightId: UUID? {
        return highlight.id ?? nil
    }
    
    var text: String {
        return highlight.text ?? ""
    }
    
    var color: UIColor {
        return highlight.color ?? UIColor.yellow
    }
    
    var fileName: String {
        return highlight.fileName ?? ""
    }
    
    var createdDate: Date {
        return highlight.createdDate ?? Date()
    }
    
    var isShowOnWatch: Bool {
        return highlight.isShowOnWatch
    }
    
    var selections: [SelectionLineViewModel] {
        return (highlight.selectionLines?.allObjects as? [SelectionLine] ?? []).map(SelectionLineViewModel.init)
    }
    
    func updateColor(color: Color) {
        highlight.color = UIColor(color)
        highlight.save()
    }
    
    func toggleIsShowOnWatch() {
        highlight.isShowOnWatch.toggle()
        highlight.save()
    }
    
    var isShowDetail: Bool = false
}
