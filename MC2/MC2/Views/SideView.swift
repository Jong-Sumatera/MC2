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
    @StateObject var selectedTagVM = SelectedTagsViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(sortDescriptors: []) var files: FetchedResults<File>
    @State var selection: Int?
    
    
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination:DashboardView(), tag: 0, selection: $selection) {
                    Label("Home",systemImage: "house")
                        .foregroundColor(selection == 0 ? Color.primaryColor : .white)
                    
                }
                .listRowBackground((selection == 0 ? Color.white : Color.clear).clipped()
                    .cornerRadius(10))
                
                
                if file != nil {
                    NavigationLink(destination: DocumentView(file: file!), tag: 1, selection: $selection) {
                    }.hidden()
                }
                
                Section(header: Text("Recent Files").foregroundColor(.white)) {
                    ForEach($tagListVM.tags, id: \.tagId) { (tag : Binding<TagViewModel>) in
                        Toggle(isOn: tag.isSelected, label: {
                                Label("\(tag.tag.title.wrappedValue ?? "")", systemImage: "tag")
                                    .foregroundColor(tag.isSelected.wrappedValue ? Color.primaryColor : .white)
                            
                            
                        }).toggleStyle(ButtonToggleStyle())
                            .tint(.white)
                            
                        
                    }
                }
                
                Section(header: Text("Tags").foregroundColor(.white)) {
                    ForEach($tagListVM.tags, id: \.tagId) { (tag : Binding<TagViewModel>) in
                        Toggle(isOn: tag.isSelected, label: {
                                Label("\(tag.tag.title.wrappedValue ?? "")", systemImage: "tag")
                                    .foregroundColor(tag.isSelected.wrappedValue ? Color.primaryColor : .white)
                            
                            
                        }).toggleStyle(ButtonToggleStyle())
                            .tint(.white)
                            
                        
                    }
                }
                
            }
            .onAppear{
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
                        self.file = file
                        self.selection = 1
                        
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
