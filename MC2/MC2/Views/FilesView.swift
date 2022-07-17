//
//  FilesView.swift
//  MC2
//
//  Created by Clara Evangeline on 03/07/22.
//

import SwiftUI

struct FilesView: View {
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)]) var files: FetchedResults<File>
//    @EnvironmentObject var oo: SearchObservableObject
    
    @ObservedObject var vm: FilesListViewModel
    var body: some View {
        
        List {
            ForEach(vm.files, id: \.id) { file in
                NavigationLink(destination: DocumentView(file: file), label: {
                    Text(file.fileTitle)
                })
            }
            
        }.onAppear{
            vm.getFiles()
        }
    }
}
