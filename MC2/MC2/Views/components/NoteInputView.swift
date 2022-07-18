//
//  NoteInputView.swift
//  MC2
//
//  Created by Widya Limarto on 18/07/22.
//

import SwiftUI

struct NoteInputView: View {
    @Binding var isAddingNote: Bool
    
    @State var noteText: String = ""
    @State var tags: String = ""
    
    @State var notePlaceholderText: String = "add note"
    @State var tagsPlaceholderText: String = "#tags"
    @FocusState private var isFocusedNote: Bool
    @FocusState private var isFocusedTags: Bool
    
    var body: some View {
        VStack{
            ZStack{
                if noteText.isEmpty && !isFocusedNote {
                    TextEditor(text: $notePlaceholderText)
                        .frame(minHeight: 38, alignment: .leading)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 5)
                        .disabled(true)
                        .opacity(0.5)
                }
                
                TextEditor(text: $noteText)
                    .focused($isFocusedNote)
                    .frame(minHeight: 38, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 5)
                    .opacity(noteText.isEmpty ? 0.3 : 1)
                    .onChange(of: noteText, perform: { newValue in
                        self.isAddingNote = !newValue.isEmpty || !self.tags.isEmpty
                    })
                //                    .overlay(
                //                             RoundedRectangle(cornerRadius: 8)
                //                               .stroke(Color.gray, lineWidth: 1)
                //                             )
                
            }
            
            HStack{
                Image(systemName: "tag")
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                ZStack{
                    if tags.isEmpty && !isFocusedTags {
                        TextEditor(text: $tagsPlaceholderText)
                            .frame(minHeight: 38, alignment: .leading)
                            .padding(.horizontal, 5)
                            .disabled(true)
                            .opacity(0.5)
                        
                    }
                    TextEditor(text: $tags)
                        .frame(minHeight: 38, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 5)
                        .opacity(tags.isEmpty ? 0.3 : 1)
                        .onChange(of: tags, perform: { newValue in
                            self.isAddingNote = !newValue.isEmpty || !self.noteText.isEmpty
                        })
                    //                    .overlay(
                    //                             RoundedRectangle(cornerRadius: 8)
                    //                               .stroke(Color.gray, lineWidth: 1)
                    //                             )
                }
            }
            
            Divider().padding(10)
        }
    }
}

struct NoteInputView_Previews: PreviewProvider {
    static var previews: some View {
        NoteInputView(isAddingNote: .constant(false))
    }
}
