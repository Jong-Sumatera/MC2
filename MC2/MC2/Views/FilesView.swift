//
//  FilesView.swift
//  MC2
//
//  Created by Clara Evangeline on 03/07/22.
//

import SwiftUI

struct FilesView: View {
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)]) var files: FetchedResults<File>
    
    @ObservedObject var vm: FilesListViewModel
    var body: some View {
        VStack(alignment: .leading){
            if(vm.search != "") {
                Text("There are \(vm.files.count) files found for \"\(vm.search)\"")
                    .font(.system(size: 24))
                    .bold()
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
            }
            
            if(vm.files.count == 0) {
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Text("Tap to button + to add document")
                            .foregroundColor(.gray)
                            .opacity(0.5)
                            .font(.system(size: 24))
                        Spacer()
                    }
                    Spacer()
                }
                
                
            } else {
                List {
                    ForEach(vm.files, id: \.id) { file in
                        HStack {
                            Text(file.fileTitle)
                                .foregroundColor(.black)
                            NavigationLink(destination: DocumentView(file: file)) { EmptyView()}.opacity(0)
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.lightGrayColor)
                        }
                    }
                    .onDelete(perform: { i in
                        i.forEach{index in
                            vm.files[index].file.delete()
                        }
                    })
                    .listRowBackground(Color.fileListColor)
                    
                }
            }
            
            
            
        }.onAppear{
            vm.getFiles()
        }
        
    }
}
