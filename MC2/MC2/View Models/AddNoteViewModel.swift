//
//  AddNoteViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 19/07/22.
//

import Foundation

class AddNoteViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var tags: String = ""
    
    func addNoteToHighlight(highlightVM: HighlightViewModel) -> NoteViewModel? {
        let note = Note(context: Note.context)
        note.id = UUID()
        note.createdDate = Date()
        note.modifiedDate = Date()
        note.text = text
        
        if !tags.isEmpty {
            
            let tagsArr = tags.replacingOccurrences(of: " ", with: "").split(separator: "#")
            
            var tagsModel: [Tag] = []
            for tag in tagsArr {
                let res: [Tag] = Tag.findBy(format: "title == %@", "#\(tag)" as CVarArg)
                if res.count > 0 {
                    tagsModel.append(res[0])
                } else {
                    let newTag = Tag(context: Tag.context)
                    newTag.createdDate = Date()
                    newTag.id = UUID()
                    newTag.title = "#\(tag)"
                    tagsModel.append(newTag)
                }
                
            }
            note.addToTags(NSSet(array: tagsModel))
        }
        
        note.highlight = highlightVM.highlight
        
        let res = note.save()
        if res {
            text = ""
            tags = ""
            return NoteViewModel(note: note)
        } else {
            return nil
        }
    }
}
