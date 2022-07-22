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
            
            List {
                ForEach(vm.files, id: \.id) { file in
                    
                    NavigationLink(destination: DocumentView(file: file), label: {
                        Text(file.fileTitle)
                    })
                }
                .onDelete(perform: { i in
                    i.forEach{index in
                        vm.files[index].file.delete()
                    }
                })
                .listRowBackground(Color.secondaryColor.opacity(0.1))
                
            }.onAppear{
                vm.getFiles()
            }
            
        }
        
    }
}
