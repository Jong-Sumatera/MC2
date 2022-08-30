//
//  UpdateNoteViewModel.swift
//  MC2
//
//  Created by Widya Limarto on 30/08/22.
//

import Foundation

class UpdateNoteViewModel: ObservableObject {
    @Published var text: String = "" {
        didSet {
            updateNoteText()
        }
    }
    @Published var tags: String = "" {
        didSet {
            updateNoteTags()
        }
    }
    
    var noteVM: NoteViewModel
    
    init(noteVM: NoteViewModel) {
        self.noteVM = noteVM
        self.text = noteVM.text
        self.tags = noteVM.tags.reduce("") { $0.appending(" \($1.title)") }.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func updateNoteText() {
        noteVM.note.modifiedDate = Date()
        noteVM.note.text = text
    }
    
    func updateNoteTags() {
        noteVM.note.modifiedDate = Date()
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
            noteVM.note.removeFromTags(noteVM.note.tags ?? NSSet(array: []))
            noteVM.note.addToTags(NSSet(array: tagsModel))
        }
    }
    
}
