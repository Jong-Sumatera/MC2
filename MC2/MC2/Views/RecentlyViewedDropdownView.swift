//
//  RecentlyViewedDropdownView.swift
//  MC2
//
//  Created by Clara Evangeline on 04/07/22.
//

import SwiftUI

struct RecentlyViewedDropdownView: View {
    @State var expanded: Bool = false
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)]) var files: FetchedResults<File>
    
    var body: some View {
        Text("blank")
//        var recentFiles = files.prefix(upTo: 4)
//
//        var menu = VStack(alignment: .leading){
//            HStack{
//                Text("Recently Viewed").fontWeight(.heavy)
//                Image(systemName: self.expanded ? "chevron.up" : "chevron.down").resizable()
//            }.onTapGesture {
//                self.expanded.toggle()
//            }.frame(width: menu.width)
//            if (self.expanded){
//                ForEach(recentFiles, id: \.self) {
//                    self.menuItem(recentFiles[$0])
//                }
//            }
//        }
//            .animation(.none)
//            .onTapGesture {
//                self.expanded.toggle()
//            }
//        return menu
//    }
//
//    private func menuItem(_ recentFiles: String, _ width: CGFloat) -> some View {
//        let padding: CGFloat = 20
//        let height: CGFloat = 20
//
//        return VStack {
//            Divider().background(color)
//            Button(action: {self.expanded.toggle()}){
//                Text("\(recentFiles)".frame(width: CGFloat, height: CGFloat, alignment: .leading))
//            }
//            .frame.contentShape(Rectangle())
//        }
    }
}

struct RecentlyViewedDropdownView_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyViewedDropdownView()
    }
}
