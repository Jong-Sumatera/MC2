//
//  DashboardView.swift
//  LearnUp
//
//  Created by Dewi Nurul Hamidah on 29/06/22.
//

import SwiftUI

struct DashboardView: View {
    @State private var selectedIndex = 0
    @State private var searchText = ""
    
    @StateObject var fileListVM = FilesListViewModel()
    @StateObject var highlightListVM = DashboardHighlightListViewModel()
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)]) var tags: FetchedResults<Tag>

    @State var tag: TagViewModel?
    
    var body: some View {
        VStack{
            
            if (selectedIndex == 0) {
                FilesView(vm: fileListVM)
            } else if (selectedIndex == 1) {
                HighlightsView(vm: highlightListVM, tag: tag)
            }
            
        }
        .onAppear{
            if tag != nil {
                selectedIndex = 1
            }
        }
        .navigationBarTitle(tag != nil ? tag?.title ?? "" : "Home", displayMode: .inline)
        .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading){
                    Picker(selection: $selectedIndex, label: CustomEmptyView()) {
                            Text("Files")
                                .tag(0)
                        Text("Highlights")
                            .tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            
           
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing){
                List {}
                    .searchable(text: selectedIndex == 0 ? $fileListVM.search : $highlightListVM.search){
                    }
                    .onChange(of: selectedIndex == 0 ? fileListVM.search : highlightListVM.search) { _ in
                        if (selectedIndex == 0) {
                            fileListVM.getFiles()
                        } else {
                            highlightListVM.getHighLights()
                        }
                    }
            }
        }
    }
}

//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            DashboardView()
//                .previewInterfaceOrientation(.landscapeLeft)
//            DashboardView()
//                .previewInterfaceOrientation(.landscapeLeft)
//        }
//    }
//}
