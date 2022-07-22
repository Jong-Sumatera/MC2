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
    
    var translationText: String? {
        let res = Translation.findByText(text: text)
        if (res != nil) {
            return res!.translationText ?? nil
        }
        return nil
    }
    
    var notes: [NoteViewModel] {
        if highlightId != nil {
            let res: [Note] = Note.getNotesByHighlight(highlight: highlight)
            return res.map(NoteViewModel.init)
        } else {
            return []
        }
//        return (highlight.notes?.allObjects as! [Note]).map(NoteViewModel.init)
    }
    
    var file: FileViewModel? {
        if highlight.file != nil {
            return FileViewModel(file: highlight.file!)
        }else{
            return nil
        }
    }
 
}
