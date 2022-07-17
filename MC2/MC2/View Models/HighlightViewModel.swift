//
//  HighlightViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 17/07/22.
//

import Foundation
import CoreData
import UIKit

struct HighlightViewModel {
    var highlight: Highlight
    
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
    
    var selections: [SelectionLineViewModel] {
        return SelectionLine.all().map(SelectionLineViewModel.init)
    }
}
