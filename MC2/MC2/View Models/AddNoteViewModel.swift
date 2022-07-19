//
//  AddNoteViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 19/07/22.
//

import Foundation

class AddNoteViewModel: ObservableObject {
    @Published var text: String = ""
    
    func addNoteToHighlight(highlightVM: HighlightViewModel) -> NoteViewModel? {
        let note = Note(context: Note.context)
        note.id = UUID()
        note.createdDate = Date()
        note.modifiedDate = Date()
        note.text = text
        note.highlight = highlightVM.highlight
        
        let res = note.save()
        if res {
            text = ""
            return NoteViewModel(note: note)
        } else {
            return nil
        }
    }
}
