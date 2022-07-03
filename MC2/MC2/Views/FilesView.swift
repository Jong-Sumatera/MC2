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

    var body: some View {
        List {
            ForEach(files, id: \.id) { file in
                NavigationLink(destination: DocumentView(filePath: URL(string: file.fileUrl!)!,fileName: file.fileName ?? ""), label: {
                    Text("\(file.fileName ?? "")")
                })
        }
        }
    }
}

struct FilesView_Previews: PreviewProvider {
    static var previews: some View {
        FilesView()
    }
}
