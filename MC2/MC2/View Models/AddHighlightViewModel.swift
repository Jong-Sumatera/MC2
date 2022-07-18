//
//  AddHighlightViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 15/07/22.
//

import Foundation
import UIKit

class AddHighlightViewModel {
    var text: String = ""
    var color: UIColor = UIColor.yellow
    
    func addHighlight(id: UUID, fileVM: FileViewModel, selectionsVM: [SelectionLineViewModel], translation: TranslationViewModel?) -> HighlightViewModel? {
        let highlight = Highlight(context: Highlight.context)
        highlight.id = id
        highlight.createdDate = Date()
        highlight.text = text
        highlight.color = color
        highlight.file = fileVM.file
        highlight.fileName = fileVM.fileTitle
        let selections = selectionsVM.map{ $0.selection }
        highlight.addToSelectionLines(NSSet(array:selections))
        
        if let translation = translation {
            highlight.translation = translation.translation
        }
        
        let res = highlight.save()
        
        if res {
            return HighlightViewModel(highlight: highlight)
        }
        return nil
        
    }
}
