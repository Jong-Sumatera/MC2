//
//  NoteInputView.swift
//  MC2
//
//  Created by Widya Limarto on 18/07/22.
//

import SwiftUI

struct NoteInputView: View {
    @ObservedObject var addNotesVM : AddNoteViewModel
    @Binding var isAddingNote: Bool
    
    @State var tags: String = ""
    
    @State var notePlaceholderText: String = "add note"
    @State var tagsPlaceholderText: String = "#tags"
    @FocusState private var isFocusedNote: Bool
    @FocusState private var isFocusedTags: Bool
    

    
    var body: some View {
        VStack{
            ZStack{
                if addNotesVM.text.isEmpty && !isFocusedNote {
                    TextEditor(text: $notePlaceholderText)
                        .frame(minHeight: 38, alignment: .leading)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 5)
                        .disabled(true)
                        .opacity(0.5)
                }
                
                TextEditor(text: $addNotesVM.text)
                    .focused($isFocusedNote)
                    .frame(minHeight: 38, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 5)
                    .opacity(addNotesVM.text.isEmpty ? 0.3 : 1)
                    .onChange(of: addNotesVM.text, perform: { newValue in
                        self.isAddingNote = !newValue.isEmpty || !self.addNotesVM.tags.isEmpty
                    })
                //                    .overlay(
                //                             RoundedRectangle(cornerRadius: 8)
                //                               .stroke(Color.gray, lineWidth: 1)
                //                             )
                
            }
            
            HStack{
                Image(systemName: "tag")
                    .foregroundColor(.textColor)
                    .padding(.leading, 10)
                ZStack{
                    if tags.isEmpty && !isFocusedTags {
                        TextEditor(text: $tagsPlaceholderText)
                            .frame(minHeight: 38, alignment: .leading)
                            .padding(.horizontal, 5)
                            .disabled(true)
                            .opacity(0.5)
                        
                    }
                    TextEditor(text: $addNotesVM.tags)
                        .foregroundColor(.blue)
                        .frame(minHeight: 38, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 5)
                        .opacity(addNotesVM.tags.isEmpty ? 0.3 : 1)
                        .onChange(of: addNotesVM.tags, perform: { newValue in
                            self.isAddingNote = !newValue.isEmpty || !self.addNotesVM.text.isEmpty
                            
                            modifyTags(q: newValue)
                        })
                        
                    //                    .overlay(
                    //                             RoundedRectangle(cornerRadius: 8)
                    //                               .stroke(Color.gray, lineWidth: 1)
                    //                             )
                }
            }
            .onChange(of: isAddingNote, perform: { i in
                if !isAddingNote {
                    self.isFocusedTags = false
                    self.isFocusedNote = false
                }
                
            })
            
            Divider().padding(10)
        }
    }
    
    func modifyTags(q: String){
        var text = q
//        text = q.replacingOccurrences(of: "(?<=\\S)\\s(?=\\S)(?![#])", with: " #", options: .regularExpression)
        text = q.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression).replacingOccurrences(of: "(\\s|^)(?=\\S)(?![#])", with: " #", options: .regularExpression).replacingOccurrences(of: "^\\s+", with: "", options: .regularExpression)
        
        self.addNotesVM.tags = text
    }
}

struct NoteInputView_Previews: PreviewProvider {
    static var previews: some View {
        NoteInputView(addNotesVM: AddNoteViewModel(), isAddingNote: .constant(false))
    }
}
