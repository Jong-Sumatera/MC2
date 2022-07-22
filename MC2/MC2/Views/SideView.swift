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
    @StateObject var tagListVM = TagListViewModel()
    @StateObject var recentFileVM = RecentFilesViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(sortDescriptors: []) var files: FetchedResults<File>
    
//    @State var selection: String? = "home"
    @EnvironmentObject var selection : ActiveScreenViewModel
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination:DashboardView(), tag: Screen.home.rawValue, selection: $selection.screen) {
                    Label("Home",systemImage: "house")
                        .foregroundColor(selection.screen == Screen.home.rawValue ? Color.primaryColor : .white)
                    
                }
                .listRowBackground((selection.screen == Screen.home.rawValue ? Color.white : Color.clear).clipped()
                    .cornerRadius(10))
                
                
//                if file != nil {
//                    NavigationLink(destination: DocumentView(file: file!), tag: Screen.document.rawValue, selection: $selection.screen) {
//                    }.hidden()
//                }
                
                Section(header: Text("Recent Added").foregroundColor(.white)) {
                    ForEach(recentFileVM.files, id: \.fileId) { f in
                        NavigationLink(destination: DocumentView(file: f), tag: f.fileUrl!.absoluteString, selection: $selection.screen) {
                            Label("\(f.fileTitle)", systemImage: "doc")
                                .foregroundColor(selection.screen == f.fileUrl?.absoluteString ? Color.primaryColor : .white)
                                .padding(0)
                        }
                        .listRowBackground((selection.screen == f.fileUrl?.absoluteString ? Color.white : Color.clear).clipped()
                            .cornerRadius(10))
                    }
                }
                
                Section(header: Text("Tags").foregroundColor(.white)) {
                    ForEach($tagListVM.tags, id: \.tagId) { (tag : Binding<TagViewModel>) in
                        //                        Toggle(isOn: tag.isSelected, label: {
                        let tagTitle = tag.tag.title.wrappedValue ?? ""
                        NavigationLink(destination:DashboardView(tag: TagViewModel(tag.tag.wrappedValue)), tag: tagTitle, selection: $selection.screen) {
                            Label("\(tagTitle)", systemImage: "tag")
                            //                                    .foregroundColor(tag.isSelected.wrappedValue ? Color.primaryColor : .white)
                                .foregroundColor(selection.screen == tagTitle ? Color.primaryColor : .white)
                                .padding(0)
                        }
                        .listRowBackground((selection.screen == tagTitle ? Color.white : Color.clear).clipped()
                            .cornerRadius(10))
                        
                        //                        })
                        //                        .toggleStyle(ButtonToggleStyle())
                        //                        .tint(.white)
                        //
                        
                    }
                }
                
            }
            .onAppear{
                recentFileVM.getFiles()
                tagListVM.getTags()
            }
            .navigationTitle("LearnUp")
            .navigationBarItems(trailing: HStack {
                
                Button(action: {
                    print("Reload button pressed...")
                }) {
                    Image(systemName: "gear")
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    self.showPopover = true
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
                .popover(isPresented: self.$showPopover,
                         attachmentAnchor: .point(.topLeading), arrowEdge: .trailing) {
                    AddFileView(addFileVM: addFileVM, onPressAdd: { file in
//                        self.file = file
                        self.selection.screen = file?.fileUrl!.absoluteString
                        
                    })
                }
            })
            .background(Color.primaryColor)
            
            DashboardView()
        }.navigationBarHidden(true)
    }
}


struct SideView_Previews: PreviewProvider {
    static var previews: some View {
        SideView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

