//
//  SideView.swift
//  LearnUp
//
//  Created by Dewi Nurul Hamidah on 29/06/22.
//

import SwiftUI

struct SideView: View {
    @State var showPopover: Bool = false
    @State var fileName: String = ""
    @State var isShowing: Bool = false
    @State var filePath: URL?
    @State var lastPath: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var files: FetchedResults<File>
    @State var isGotoDocumentview: Bool = false
    
    var body: some View {
        NavigationView {
            
            //            Text("total files\(files.count )")
            //            List {
            //                ForEach(files) {
            //                    file in
            //                    VStack{
            //                        Text("\(file.fileName ?? "")")
            //                    }
            //                }
            //            }
            
            List {
                NavigationLink(destination:DashboardView()) {
                    Label("Home",systemImage: "house")
                }
                
                List {
                    
                }
                
                if isGotoDocumentview {
                    NavigationLink(destination: DocumentView(filePath: filePath!, fileName: fileName), isActive: $isGotoDocumentview) {
                    }.hidden()
                }
                
            }.navigationBarItems(trailing:
                                    HStack {
                
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
                    VStack{
                        HStack{
                            Button(action: {
                                
                            }) {
                                Text("Cancel").padding(.init(top: 15, leading: 15, bottom: 15, trailing: 80))
                            }
                            
                            Button(action:  {
                                addFileToCoreData()
                                self.isGotoDocumentview = true
                                self.showPopover = false
                            }) {
                                Text("Add").padding(.init(top: 15, leading: 80, bottom: 15, trailing: 15))
                            }.disabled(self.filePath != nil ? false : true)
                            
                        }
                        TextField("File Name", text: $fileName)
                            .padding(.init(top: 15, leading: 15, bottom: 15, trailing: 15))
                        
                        
                        if lastPath != "" {
                            Text(lastPath)
                            Spacer()
                                .frame(height: 10)
                        }
                        Button(action: {
                            isShowing = true
                        }) {
                            HStack{
                                Image(systemName: "square.and.arrow.down")
                                Text("Import PDF")
                            }
                        }
                        .fileImporter(isPresented: $isShowing, allowedContentTypes: [.pdf], allowsMultipleSelection: false, onCompletion: { results in
                            
                            
                            switch results {
                            case .success(let fileurls):
                                
                                for fileurl in fileurls {
                                    filePath = fileurl
                                    lastPath = fileurl.lastPathComponent
                                }
                                
                            case .failure(let error):
                                print(error)
                            }
                            
                        })
                    }
                    .frame(width: 300, height: 210, alignment: .topTrailing)
                }
            })
            
            
            
            DashboardView()
        }
    }
    func addFileToCoreData(){
        let newFile = File(context: viewContext)
        newFile.fileName = fileName
        newFile.id = UUID()
        newFile.fileType = "pdf"
        newFile.createdDate = Date()
        newFile.fileTitle = lastPath
        newFile.fileUrl = filePath?.absoluteString
        newFile.modifiedDate = Date()
        do {
            try viewContext.save()
        } catch{
            print(error.localizedDescription)
        }
    }
}

struct SideView_Previews: PreviewProvider {
    static var previews: some View {
        SideView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
