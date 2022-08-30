//
//  UpdateNotesView.swift
//  MC2
//
//  Created by Widya Limarto on 30/08/22.
//

import SwiftUI

struct UpdateNotesView: View {
    @StateObject var vm: UpdateNoteViewModel
    @Binding var isSave: Bool
    
    @State var notePlaceholderText: String = "add note"
    @State var tagsPlaceholderText: String = "#tags"
    
    @State var tags: String = ""
    
    @FocusState private var isFocusedNote: Bool
    @FocusState private var isFocusedTags: Bool
    
    var body: some View {
        VStack{
            ZStack{
                if vm.text.isEmpty && !isFocusedNote {
                    TextEditor(text: $notePlaceholderText)
                        .frame(minHeight: 38, alignment: .leading)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 5)
                        .disabled(true)
                        .opacity(0.5)
                        
                }
                
                TextEditor(text: $vm.text)
                    .focused($isFocusedNote)
                    .frame(minHeight: 38, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 5)
                    .opacity(vm.text.isEmpty ? 0.3 : 1)
                    
//                    .onChange(of: addNotesVM.text, perform: { newValue in
//                        self.isAddingNote = !newValue.isEmpty || !self.addNotesVM.tags.isEmpty
//                    })
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
                    if vm.tags.isEmpty && !isFocusedTags {
                        TextEditor(text: $tagsPlaceholderText)
                            .frame(minHeight: 38, alignment: .leading)
                            .padding(.horizontal, 5)
                            .disabled(true)
                            .opacity(0.5)
                        
                    }
                    TextEditor(text: $vm.tags)
                        .foregroundColor(.blue)
                        .frame(minHeight: 38, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 5)
                        .opacity(vm.tags.isEmpty ? 0.3 : 1)
                        .onChange(of: vm.tags, perform: { newValue in
                            modifyTags(q: newValue)
                        })
                        
                    //                    .overlay(
                    //                             RoundedRectangle(cornerRadius: 8)
                    //                               .stroke(Color.gray, lineWidth: 1)
                    //                             )
                }
            }
//            .onChange(of: isSave, perform: { i in
//                if(i) {
//                    do {
//                        try Note.context.save()
//                    } catch {
//                        print("failed to update")
//                        Note.context.rollback()
//                    }
//
//                }
//            })
//            .onChange(of: isAddingNote, perform: { i in
//                if !isAddingNote {
//                    self.isFocusedTags = false
//                    self.isFocusedNote = false
//                }
//
//            })
            
            Divider().padding(10)
        }
    }
    
    func modifyTags(q: String) {
        var text = q
//        text = q.replacingOccurrences(of: "(?<=\\S)\\s(?=\\S)(?![#])", with: " #", options: .regularExpression)
        text = q.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression).replacingOccurrences(of: "(\\s|^)(?=\\S)(?![#])", with: " #", options: .regularExpression).replacingOccurrences(of: "^\\s+", with: "", options: .regularExpression)
        
        self.vm.tags = text
    }
}
//
//struct UpdateNotesView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateNotesView(vm: <#UpdateNoteViewModel#>)
//    }
//}
