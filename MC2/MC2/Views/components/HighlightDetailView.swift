//
//  HighlightDetailView.swift
//  MC2
//
//  Created by Widya Limarto on 18/07/22.
//

import SwiftUI

struct HighlightDetailView: View {
    @State var highlightVM: HighlightViewModel
    @State var color: Color
    
    @State var selected: Int = 0
    @State var isAddingNote: Bool = false
    @State var isShowNotesOptions: Bool = false
    
    @State var text: String = ""
    @State var translation: String = ""
    @State var isShowOnWatch: Bool = false
    
    @StateObject var addNotesVM = AddNoteViewModel()
    @StateObject var notesListVM = NotesListViewModel()
    
    var body: some View {
        VStack {
            HStack{
                Picker("", selection: $selected, content: {
                    Text("Translation").tag(0)
                    Text("Notes").tag(1)
                    Text("Similar Notes").tag(2)
                })
                .pickerStyle(SegmentedPickerStyle())
                .frame(maxWidth: 350)
                Spacer()
                if(isAddingNote) {
                    Button(action: {
                        let res = addNotesVM.addNoteToHighlight(highlightVM: highlightVM)
                        self.isAddingNote = false
                    }, label: {
                        Image(systemName: "checkmark")
                    })
                    .frame(width: 24, height: 22)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.blue)
                }else {
                    Button(action: {
                        self.isShowNotesOptions = true
                    }, label: {
                        Image(systemName: "ellipsis")
                    })
                    .frame(width: 24, height: 22)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.blue)
                    .actionSheet(isPresented: $isShowNotesOptions) {
                        ActionSheet(
                            title: Text(""),
                            buttons: [.default(Text("Delete")) {
                                highlightVM.highlight.delete()
                            }]
                        )
                    }
                }
                
                
            }
            
            VStack{
                switch selected {
                case 0:
                    VStack(alignment: .leading){
                        Text(translation)
                            .multilineTextAlignment(.leading)
                        
                        
                        Divider().padding(.vertical, 10)
                    }
                    .padding(.top, 25)
                    .padding(.horizontal, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .task {
                        await self.getTranslation(q: self.highlightVM.text)
                    }
                    
                case 1:
                    VStack{
                        NoteInputView(addNotesVM: addNotesVM, isAddingNote: $isAddingNote)
                        VStack{
                            ForEach(notesListVM.notes, id: \.noteId) { note in
                                VStack(alignment: .leading){
                                    Text(note.text)
                                        .padding(.horizontal, 10)
                                    Text(note.modifiedDate.formattedDate)
                                        .font(.system(size: 10))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    Divider().padding(10)
                                }
                                
                            }.onDelete(perform: { i in
                                
                            })
                        }
                        
                    }
                    .padding(.top, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onAppear{
                        notesListVM.getNotesFromHighlight(highlightVM: highlightVM)
                    }
                case 2:
                    VStack{
                        Divider().padding(.vertical, 10)
                    }
                default:
                    VStack{}
                }
                
                HStack {
                    ColorPicker("", selection: $color)
                        .labelsHidden()
                        .onChange(of: color, perform: {newValue in
                            highlightVM.updateColor(color: newValue)
                        })
                    Spacer()
                    HStack{
                        Toggle("Show on watch", isOn: $isShowOnWatch)
                            .frame(width: 180)
                    }.onAppear{
                        self.isShowOnWatch = highlightVM.isShowOnWatch
                    }.onChange(of: isShowOnWatch, perform: { _ in
                        highlightVM.toggleIsShowOnWatch()
                    })
                }
                .padding(.horizontal, 5)
                
            }
            .animation(.linear, value: selected)
        }.padding(.bottom, 10)
    }
    
    func getTranslation(q: String) async {
        var res = "loading"
        
        await GTranslation.shared.translateText(q: q, targetLanguage: "id", callback: { text in
            res = text
            self.translation = res
        })

        
    }
}

struct HighlightDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightDetailView(highlightVM: HighlightViewModel(highlight: Highlight(context: Highlight.context)), color: Color.gray)
    }
}
