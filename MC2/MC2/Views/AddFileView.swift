//
//  AddFileView.swift
//  MC2
//
//  Created by Widya Limarto on 16/07/22.
//

import SwiftUI

struct AddFileView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var addFileVM : AddFileViewModel
    @State var isShowing: Bool = false
    @FocusState var isFileTitleFocus
    var onPressAdd: (_ file: FileViewModel?) -> ()
    
    var body: some View {
        
        VStack{
            HStack{
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel").padding()
                }
                
                Spacer()
                
                Button(action:  {
                    let file: FileViewModel? = addFileVM.addFile()
                    onPressAdd(file)
                    self.presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Text("Add").padding()
                }.disabled(addFileVM.fileUrl != nil ? false : true)
                
            }
            
            TextField("File Title", text: $addFileVM.fileTitle)
                .padding(.init(top: 15, leading: 15, bottom: 15, trailing: 15))
                .focused($isFileTitleFocus)
            
            
            if addFileVM.fileUrl != nil {
                HStack {
                    Text(addFileVM.fileName)
                    Button("x") {
                        addFileVM.fileUrl = nil
                    }
                }
            } else {
                Button(action: {
                    isShowing.toggle()
                }) {
                    HStack{
                        Image(systemName: "plus")
                        Text("Import PDF")
                    }
                }
                .fileImporter(isPresented: $isShowing, allowedContentTypes: [.pdf], allowsMultipleSelection: false, onCompletion: { results in
                    do{
                        let result = try results.get()
                        addFileVM.fileUrl = result[0]
                        isFileTitleFocus = true
                    } catch {
                        print(error)
                    }
                    
                })
            }
        }
        .frame(width: 300, height: 150, alignment: .topTrailing)
    }
}

struct AddFileView_Previews: PreviewProvider {
    static var previews: some View {
        AddFileView(addFileVM: AddFileViewModel(), onPressAdd: {file in })
    }
}
