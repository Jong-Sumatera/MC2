//
//  DocumentSideView.swift
//  MC2
//
//  Created by Widya Limarto on 18/07/22.
//

import SwiftUI

struct DocumentSideView: View {
    var isOpenSideBar: Bool
    
    @StateObject var highlightsListVM: HighlightsListViewModel
    
    @Binding var selectedId: UUID?
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Highlights")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            ScrollViewReader { sp in
                ScrollView{
                    ForEach($highlightsListVM.highlights, id: \.highlightId){ $highlight in
                        HighlightCellView(highlightVM: $highlight, selectedId: $selectedId)
                    }.padding(.horizontal)
                }
                .padding(.top, 10)
                .padding(.bottom, 20)
                .onReceive(highlightsListVM.$selectedHighlightId, perform: { id in
                    if let id = id {
                        let res = highlightsListVM.highlights.filter{ i in
                            i.highlightId?.uuidString ?? "" == id
                        }
                        if(res.count > 0) {
                            
                            withAnimation{
                                selectedId = res[0].highlightId
                                sp.scrollTo(res[0].highlightId)
                            }
                            highlightsListVM.selectedHighlightId = nil
                        }
                    }
                })
                
            }
        }
        .padding(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .clipped()
        .background(Color.sidebarHighlightColor.shadow(color: .gray, radius: 0.5, x: 0, y: 0.5))
        
        
        
        
    }
}

struct DocumentSideView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentSideView(isOpenSideBar: true, highlightsListVM: HighlightsListViewModel(), selectedId: .constant(nil))
    }
}
