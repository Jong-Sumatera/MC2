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
    
    var body: some View {
        VStack{
            if selectedIndex == 0 {
                FilesView()
            } else {
                HighlightsView()
            }

        } .navigationBarTitle("Home", displayMode: .inline)
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
                Text("")
                    .searchable(text: $searchText)
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
