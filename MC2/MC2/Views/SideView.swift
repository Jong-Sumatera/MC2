//
//  SideView.swift
//  LearnUp
//
//  Created by Dewi Nurul Hamidah on 29/06/22.
//

import SwiftUI

struct SideView: View {
    @State var showPopover: Bool = false
    @State var file: FileViewModel?
    
    @StateObject var addFileVM = AddFileViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(sortDescriptors: []) var files: FetchedResults<File>
    @State var selection: Int?
    
    var body: some View {
        NavigationView {
            
            List {
                NavigationLink(destination:DashboardView(), tag: 0, selection: $selection) {
                    Label("Home",systemImage: "house")
                }
                
                if file != nil {
                    NavigationLink(destination: DocumentView(file: file!), tag: 1, selection: $selection) {
                    }.hidden()
                }
                
            }.navigationBarItems(trailing: HStack {
                
                Button(action: {
                    print("Reload button pressed...")
                }) {
                    Image(systemName: "gear")
                }
                
                Button(action: {
                    self.showPopover = true
                }) {
                    Image(systemName: "plus")
                }
                .popover(isPresented: self.$showPopover,
                         attachmentAnchor: .point(.topLeading), arrowEdge: .trailing) {
                    AddFileView(addFileVM: addFileVM, onPressAdd: { file in
                        self.file = file
                        self.selection = 1
                        
                    })
                }
            })
        }
    }
}


struct SideView_Previews: PreviewProvider {
    static var previews: some View {
        SideView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
