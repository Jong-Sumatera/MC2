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
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)]) var files: FetchedResults<File>
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)]) var highlights: FetchedResults<Tag>
    
    var body: some View {
        VStack{
            if (selectedIndex == 0 && files.count == 0) {
                EmptyView()
            } else if (selectedIndex == 1 && highlights.count == 0) {
                EmptyView()
            } else if (selectedIndex == 0 && files.count > 0) {
                FilesView()
            } else if (selectedIndex == 1 && highlights.count > 0) {
                HighlightsView()
            }
            
        } .navigationBarTitle("Dashboard", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading){
                    Picker(selection: $selectedIndex, label: EmptyView()) {
                        Text("Files")
                            .tag(0)
                        Text("Highlights")
                            .tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing){
                    List {
                        // LOOPING HASIL PENCARIAN
                        ForEach(oo.searchFilesResults) { result in
                            // lihat kalian mau ngapain di sini
                            Text(result.fileName!)
                        }
                    }
                    // SEARCH FIELD OTOMATIS BUAT KITA
                    .searchable(text: $searchText){
                    }
                    
                    // KETIKA SEARCHTEXT BERUBAH, MAKA FUNCTION DI BAWAHNYA BERJALAN
                    .onChange(of: searchText) { _ in
                        if (selectedIndex == 0) {
                            // BUAT VARIABEL SEMENTARA UNTUK MENAMPUNG HASIL PENCARIAN
                            var tempFilteredFile: [File] = []
                            
                            // UNTUK SETIAP DATA DI "FILES" < core data
                            for file in files {
                                // JIKA FILE YANG ADA DI FILES = SEARCH TEXT,
                                // MAKA MASUKIN HASIL PENCARIAN KE VARIABEL DI ATAS
                                if (file.fileName!.localizedCaseInsensitiveContains(searchText)) {
                                    tempFilteredFile.append(file)
                                }
                            }
                            
                            // MASUKIN VARIABEL TADI KE SEARCH RESULTS (OBSERVABLE OBJECT)
                            oo.searchFilesResults = tempFilteredFile
                        } else {
                            // BUAT VARIABEL SEMENTARA UNTUK MENAMPUNG HASIL PENCARIAN
                            var tempFilteredTags: [Tag] = []
                            
                            // UNTUK SETIAP DATA DI "FILES" < core data
                            for tag in highlights {
                                // JIKA FILE YANG ADA DI FILES = SEARCH TEXT,
                                // MAKA MASUKIN HASIL PENCARIAN KE VARIABEL DI ATAS
                                if (tag.title!.localizedCaseInsensitiveContains(searchText)) {
                                    tempFilteredTags.append(tag)
                                }
                            }
                            
                            // MASUKIN VARIABEL TADI KE SEARCH RESULTS (OBSERVABLE OBJECT)
                            oo.searchTagsResults = tempFilteredTags
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
