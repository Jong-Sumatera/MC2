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
                    Spacer()
                    Button(action: {
                        addFileVM.fileUrl = nil
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                    })
                }
                .foregroundColor(.primaryColor)
                .padding(.bottom, 20)
                .padding(.horizontal, 15)
            } else {
                Button(action: {
                    isShowing.toggle()
                }) {
                    HStack{
                        Image(systemName: "square.and.arrow.down")
                        Text("Import PDF")
                        Spacer()
                    }
                    .foregroundColor(.primaryColor)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 15)
                }
                .fileImporter(isPresented: $isShowing, allowedContentTypes: [.pdf], allowsMultipleSelection: false, onCompletion: { results in
                    do{
                        let result = try results.get()
                        let url = result[0]
                        var bookmarkData: Data?
                        
                        let res = url.startAccessingSecurityScopedResource()
                        if !res {
                            return
                        }
                        var fileError: NSError?
                        NSFileCoordinator().coordinate(readingItemAt: url, options: .withoutChanges, error: &fileError, byAccessor: {(newURL: URL) -> Void in
                            do {
                                bookmarkData = try newURL.bookmarkData()
                                url .stopAccessingSecurityScopedResource()
                            } catch let error {
                                print("\(error)")
                                return
                            }
                        })
                        
                        addFileVM.bookmarkData = bookmarkData
                        addFileVM.fileUrl = result[0]
                        isFileTitleFocus = true
                    } catch {
                        
                        print(error)
                    }
                    
                })
            }
        }
        .frame(minWidth: 300, maxWidth: 300)
        
    }
}

struct AddFileView_Previews: PreviewProvider {
    static var previews: some View {
        AddFileView(addFileVM: AddFileViewModel(), onPressAdd: {file in })
    }
}
