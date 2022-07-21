//
//  NoteViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 19/07/22.
//

import Foundation
import CoreData

struct NoteViewModel {
    var note: Note
    
    var id: NSManagedObjectID {
        return note.objectID
    }
    
    var noteId: UUID? {
        return note.id ?? nil
    }
    
    var createdDate: Date {
        return note.createdDate ?? Date()
    }
    
    var modifiedDate: Date {
        return note.modifiedDate ?? Date()
    }
    
    var text: String {
        return note.text ?? ""
    }
    
    var tags: [TagViewModel] {
        if noteId != nil {
            let res: [Tag] = Tag.byNote(note: note)
            return res.map(TagViewModel.init)
        } else {
            return []
        }
    }
}
