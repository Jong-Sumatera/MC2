//
//  DocumentView.swift
//  MC2
//
//  Created by Widya Limarto on 29/06/22.
//

import SwiftUI
import UIKit

struct DocumentVCRepresentable: UIViewControllerRepresentable {
    var file: FileViewModel
    @Binding var isOpenSideBar : Bool
    @Binding var selectedId: UUID?
    var highlightsListVM: HighlightsListViewModel
    
    func makeCoordinator() -> Self.Coordinator { Coordinator() }
    
    class Coordinator {
        var parentObserver: NSKeyValueObservation?
    }
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboard = UIStoryboard(name: "Document", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "document") as! DocumentViewController
        controller.file = file
        controller.highlightListVM = highlightsListVM
        controller.openSideBar = openSideBar
        controller.setSelectedId = setSelectedId
        
        context.coordinator.parentObserver = controller.observe(\.parent, changeHandler: { vc, _ in
            print("parent")
        })
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        let controller = uiViewController as! DocumentViewController
        
        //        controller.toggleSideBar(isHide: !isOpenSideBar)
    }
    
    func openSideBar() {
        withAnimation{
            self.isOpenSideBar = true
        }
        
    }
    
    func setSelectedId(_ id: UUID?) {
        withAnimation{
            self.selectedId = id
        }
    }
}

struct DocumentView: View {
    var file: FileViewModel
    @State var isOpenSideBar: Bool = false
    @State var selectedId: UUID?
    
    @StateObject var highlightsListVM = HighlightsListViewModel()
    var body: some View {
        HStack{
            
            DocumentVCRepresentable(
                file: file,
                isOpenSideBar: $isOpenSideBar,
                selectedId: $selectedId,
                highlightsListVM: highlightsListVM
            )
            
            if isOpenSideBar {
                DocumentSideView(
                    isOpenSideBar: isOpenSideBar,
                    highlightsListVM: highlightsListVM,
                    selectedId: $selectedId
                )
            }
            
            
                
        }.toolbar {
            ToolbarItem(placement:ToolbarItemPlacement.navigationBarTrailing){
                Button(action: {
                    withAnimation{
                        isOpenSideBar.toggle()
                    }
                    
                }, label: {
                    Image(systemName: "sidebar.trailing")
                })
                
            }
        }.edgesIgnoringSafeArea(.bottom)
            .onAppear{
                
            }
    }
}

//struct DocumentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentView(filePath: URL(fileURLWithPath: ""), fileName: "", file: nil)
//    }
//}
