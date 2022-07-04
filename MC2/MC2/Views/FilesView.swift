//
//  FilesView.swift
//  MC2
//
//  Created by Clara Evangeline on 03/07/22.
//

import SwiftUI

struct FilesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)]) var files: FetchedResults<File>
    @EnvironmentObject var oo: SearchObservableObject
    
    var body: some View {
        
        List {
            if(oo.searchFilesResults.isEmpty) {
                ForEach(files, id: \.id) { file in
                    NavigationLink(destination: DocumentView(filePath: URL(string: file.fileUrl!)!,fileName: file.fileName ?? ""), label: {
                        Text("\(file.fileName ?? "")")
                    })
                }
            } else {
                ForEach(oo.searchFilesResults, id: \.id) {
                    file in
                    NavigationLink(destination: DocumentView(filePath: URL(string: file.fileUrl!)!,fileName: file.fileName ?? ""), label: {
                        Text("\(file.fileName ?? "")")
                    })
                }
            }
            
        }
    }
}
