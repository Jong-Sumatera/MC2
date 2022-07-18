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
    
    @State var selected: Int = 1
    @State var isAddingNote: Bool = false
    @State var isShowNotesOptions: Bool = false
    
    @State var text: String = ""
    @State var translation: String = "fsfdsfas"
    
    @State var notes: [Comment] = []
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
                            title: Text(""
                                       ), buttons: [
                                        .default(Text("Delete")) {
                                            
                                        }
                                       ]
                        )
                    }
                }
                
                
            }
            
            VStack{
                switch selected {
                case 0:
                    VStack{
                        Text(translation)
                            .multilineTextAlignment(.leading)
                        
                    }
                    .padding(.top, 25)
                    .padding(.horizontal, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                case 1:
                    VStack{
                        NoteInputView(isAddingNote: $isAddingNote)
                        VStack{
                            ForEach(notes, id: \.id) { note in
                                
                            }
                        }
                        HStack {
                            ColorPicker("", selection: $color)
                                .labelsHidden()
                                .onChange(of: color, perform: {newValue in
                                    highlightVM.updateColor(color: newValue)
                                })
                            Spacer()
                        }
                    }
                    .padding(.top, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                default:
                    VStack{}
                }
                
                
            }
            .animation(.linear, value: selected)
        }.padding(.bottom, 10)
    }
}

struct HighlightDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightDetailView(highlightVM: HighlightViewModel(highlight: Highlight(context: Highlight.context)), color: Color.gray)
    }
}
