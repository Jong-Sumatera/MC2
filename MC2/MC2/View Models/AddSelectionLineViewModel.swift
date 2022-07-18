//
//  AddSelectionLineViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 17/07/22.
//

import Foundation
import UIKit

class AddSelectionLineViewModel {
    var bounds: CGRect?
    var page: Int?
    
    func addSelectionLine() -> SelectionLineViewModel? {
        let selection = SelectionLine(context: SelectionLine.context)
        selection.createdDate = Date()
        selection.id = UUID()
        selection.x = Double(bounds?.origin.x ?? 0)
        selection.y = Double(bounds?.origin.y ?? 0)
        selection.width = Double(bounds?.width ?? 0)
        selection.height = Double(bounds?.height ?? 0)
        selection.page = Int64(page!)
        
        let res = selection.save()
        if res {
            return SelectionLineViewModel(selection: selection)
        }else {
            return nil
        }
    }
    
    
}
