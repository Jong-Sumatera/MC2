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
    @EnvironmentObject var oo: SearchObservableObject
    
    @StateObject var fileListVM = FilesListViewModel()

    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)]) var tags: FetchedResults<Tag>
    
    var body: some View {
        VStack{
            if (selectedIndex == 0) {
                FilesView(vm: fileListVM)
            } else if (selectedIndex == 1) {
                TagsView()
            }
            
        } .navigationBarTitle("Home", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading){
                    Picker(selection: $selectedIndex, label: EmptyView()) {
                        Text("Files")
                            .tag(0)
                        Text("Tags")
                            .tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing){
                    List {}
                    .searchable(text: selectedIndex == 0 ? $fileListVM.search : $searchText){
                    }
                    .onChange(of: selectedIndex == 0 ? fileListVM.search : searchText) { _ in
                        if (selectedIndex == 0) {
                            fileListVM.getFiles()
                        } else {
//                            // BUAT VARIABEL SEMENTARA UNTUK MENAMPUNG HASIL PENCARIAN
//                            var tempFilteredTags: [Tag] = []
//
//                            // UNTUK SETIAP DATA DI "FILES" < core data
//                            for tag in tags {
//                                // JIKA FILE YANG ADA DI FILES = SEARCH TEXT,
//                                // MAKA MASUKIN HASIL PENCARIAN KE VARIABEL DI ATAS
//                                if (tag.title!.localizedCaseInsensitiveContains(searchText)) {
//                                    tempFilteredTags.append(tag)
//                                }
//                            }
//
//                            // MASUKIN VARIABEL TADI KE SEARCH RESULTS (OBSERVABLE OBJECT)
//                            oo.searchTagsResults = tempFilteredTags
                        }
                    }
                }
            }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView()
                .previewInterfaceOrientation(.landscapeLeft)
            DashboardView()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
