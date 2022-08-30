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
//    @State var isShowOnWatch: Bool = false
    
    @State var goToHome: Bool = false
    @State var isEditMode: Bool = false
    @State var editNotes: [NoteViewModel] = []
    @State var isSave: Bool = false
    
    @StateObject var addNotesVM = AddNoteViewModel()
    @StateObject var notesListVM = NotesListViewModel()
    @StateObject var addTranslationVM = AddTranslationViewModel()
    @StateObject var similarHighlightVM = SimilarHighlightsViewModel()
    
    @EnvironmentObject var activeScreen: ActiveScreenViewModel
    
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
                        if (res != nil) {
                            self.isAddingNote = false
                        }
                        
                    }, label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    })
                    .frame(width: 24, height: 22)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.blue)
                }else {
                    Button(action: {
                        self.isShowNotesOptions = true
                    }, label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.lightGrayColor)
                    })
                    .frame(width: 24, height: 22)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.blue)
                    .actionSheet(isPresented: $isShowNotesOptions) {
                        ActionSheet(
                            title: Text(""),
                            buttons: [
                                .default(Text("Edit Notes")) {
                                    selected = 1
                                    isEditMode = true
                                    editNotes = notesListVM.notes
                                },
                                .default(Text("Delete")) {
                                highlightVM.highlight.delete()
                            }
                            ]
                        )
                    }
                }
                
                
            }
            
            VStack{
                switch selected {
                case 0:
                    VStack(alignment: .leading){
                        Text(highlightVM.translationText ?? translation)
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
                        if (!isEditMode ||  notesListVM.notes.count == 0) {
                            NoteInputView(addNotesVM: addNotesVM, isAddingNote: $isAddingNote)
                            
                            VStack{
                                ForEach(notesListVM.notes, id: \.noteId) { note in
                                    VStack(alignment: .leading){
                                        Text(.init("\(note.text)\(Helper.tagsToString(tags: note.tags))"))
                                            .fixedSize(horizontal: false, vertical: true)
                                            .environment(\.openURL, OpenURLAction { url in
                                                activeScreen.screen = "#\(url.fragment!)"
                                                return .handled
                                            })
                                            .padding(.horizontal, 10)
                                            .padding(.bottom, 3)
                                            .textSelection(.enabled)
                                        Text("Last modified \(note.modifiedDate.formattedDate)")
                                            .font(.system(size: 10))
                                            .italic()
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .foregroundColor(.gray)
                                            .padding(.horizontal, 10)
                                        Divider().padding(10)
                                    }
                                }.onDelete(perform: { i in
                                    
                                })
                            }
                        } else {
                            HStack{
                                Button(action: {
                                    Note.context.rollback()
                                    isEditMode = false
                                }, label: {
                                    Text("Cancel")
                                })
                                Spacer()
                                Button(action: {
                                    isEditMode = false
                                    do {
                                        try Note.context.save()
                                    }catch {
                                        print("save failed")
                                    }
                                }, label: {
                                    Text("Save")
                                })
                            }
                            .padding(10)
                            .background(Color.clear)
                            Divider().padding(0)
                            
                            VStack{
                                ForEach(Array(editNotes.enumerated()), id: \.element.noteId) { (idx, note) in
                                    HStack(alignment: .top){
                                        Button(action: {
                                            editNotes.remove(at: idx)
                                            Note.context.delete(note.note)
                                        }, label: {
                                            Image(systemName: "minus.circle")
                                                .foregroundColor(.red)
                                        }).frame(width: 50, height: 50, alignment: .center)
                                        
                                        UpdateNotesView(vm: UpdateNoteViewModel(noteVM: note), isSave: $isSave)
                                    }
                                }
                            }
                            Divider().padding(10)
                        }
                        
                        
                    }
                    .padding(.top, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onAppear{
                        notesListVM.getNotesFromHighlight(highlightVM: highlightVM)
                        if(isEditMode) {
                            self.editNotes = notesListVM.notes
                        }
                    }
                case 2:
                    VStack{
                        ForEach(similarHighlightVM.similarHighlights, id: \.highlightId) { highlight in
                            SimilarItemView(highlight: highlight)
                        }
                        Divider().padding(.vertical, 10)
                    }.onAppear{
                        similarHighlightVM.getSimilarHighlights(text: highlightVM.text, currentHighlight: highlightVM)
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
//                    HStack{
//                        Toggle("Show on watch", isOn: $isShowOnWatch)
//                            .frame(width: 180)
//                    }.onAppear{
//                        self.isShowOnWatch = highlightVM.isShowOnWatch
//                    }.onChange(of: isShowOnWatch, perform: { _ in
//                        highlightVM.toggleIsShowOnWatch()
//                    })
                }
                .padding(.horizontal, 5)
                
                //            if goToHome {
                NavigationLink(destination: DashboardView(), isActive: $goToHome, label: {}).hidden()
                //            }
            }
            .animation(.linear, value: selected)
        }.padding(.bottom, 10)
    }
    
    func getTranslation(q: String) async {
        var res = "loading"
        let trans = Translation.findByText(text: q)
        
        if trans != nil {
            self.highlightVM.highlight.translation = trans
        } else {
            await GTranslation.shared.translateText(q: q, targetLanguage: "id", callback: { text in
                res = text
                self.translation = res
                addTranslationVM.text = q
                addTranslationVM.translationText = res
                addTranslationVM.addTranslation(highlightVM: highlightVM)
            })
        }
        
    }
    
}

struct HighlightDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightDetailView(highlightVM: HighlightViewModel(highlight: Highlight(context: Highlight.context)), color: Color.gray)
    }
}
