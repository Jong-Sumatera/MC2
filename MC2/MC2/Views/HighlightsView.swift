//
//  HighlightsView.swift
//  MC2
//
//  Created by Widya Limarto on 22/07/22.
//

import SwiftUI
import UIKit

struct HighlightsView: View {
    @ObservedObject var vm : DashboardHighlightListViewModel
    @State var selection: Int?
    @State var isShowAlert: Bool = false
    
    @State var tag : TagViewModel?
    @EnvironmentObject var activeScreen: ActiveScreenViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            if(vm.search != "") {
                Text("Search result for \"\(vm.search)\"")
                    .font(.system(size: 24))
                    .bold()
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
            }
            
            if(vm.highlights.count == 0) {
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Text("No highlights available")
                            .foregroundColor(.gray)
                            .opacity(0.5)
                            .font(.system(size: 24))
                        Spacer()
                    }
                    Spacer()
                }
            } else {
                List{
                    ForEach(Array(vm.highlights.enumerated()), id: \.element.id) { (index, highlight) in
                        VStack {
                            HStack{
                                VStack{
                                    ZStack{
                                        Image(systemName: "character.cursor.ibeam")
                                            .resizable()
                                            .frame(width: 22, height: 22, alignment: .center)
                                            .aspectRatio(contentMode: .fit)
                                        
                                    }
                                    .frame(width: 34, height: 34, alignment: .center)
                                    .background(Color(highlight.color))
                                    .cornerRadius(8)
                                    Spacer()
                                }
                                .padding(.trailing, 10)
                                
                                VStack(alignment: .leading){
                                    Text(.init("\(highlight.text)")).textSelection(.enabled)
                                    Text("\(highlight.fileName)")
                                        .font(.system(size: 10))
                                        .fontWeight(.semibold)
                                        .italic()
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                
                            }
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).onTapGesture(perform: {
                                if highlight.file != nil {
                                    self.selection = index
                                } else {
                                    self.isShowAlert = true
                                }
                            }).alert(isPresented: $isShowAlert, content: {
                                Alert(title: Text("404"), message: Text("File has been deleted"), dismissButton: .default(Text("Understand")))
                            }))
                            .compositingGroup()
                            .shadow(color: Color.gray, radius: 3, x: 2, y: 2)
                            .onTapGesture{
                                if highlight.file != nil {
                                    self.selection = index
                                } else {
                                    self.isShowAlert = true
                                }
                            }
                            
                            
                            Group{
                                if(highlight.notes.count > 0) {
                                    VStack{
                                        ForEach(highlight.notes, id: \.noteId) { note in
                                            VStack(alignment: .leading){
                                                Text(.init("\(note.text)\(Helper.tagsToString(tags: note.tags))"))
                                                    .environment(\.openURL, OpenURLAction { url in
                                                        activeScreen.screen = "#\(url.fragment!)"
                                                        return .handled
                                                    })
                                                    .fixedSize(horizontal: false, vertical: true)
                                                    .textSelection(.enabled)
                                                    .padding(.trailing, 5)
                                                Text("Last modified \(note.modifiedDate.formattedDate)")
                                                    .font(.system(size: 10))
                                                    .italic()
                                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                                    .foregroundColor(.gray)
                                                    .padding(.horizontal, 10)
                                                    .padding(.top, 1)
                                            }
                                            .padding(.leading, 30)
                                            Divider().padding(.top, 5)
                                        }
                                    }
                                    .padding(.top, 10)
                                    .background(RoundedRectangle(cornerRadius: 10.0).stroke(Color.gray, lineWidth: 1))
                                }
                            }
                            .padding(.leading, 54)
                            .padding(.top, 10)
                        }.background(highlight.file != nil ? NavigationLink(destination: DocumentView(file: highlight.file!), tag: index, selection: $selection) {
                            EmptyView().hidden()
                        }.hidden() : nil
                        )
                    }.onDelete(perform: { i in
                        i.forEach{index in
                            vm.highlights[index].highlight.delete()
                        }
                    })
                }
            }
        }
        .onAppear{
            if tag != nil {
                vm.tag = tag
            }
            vm.getHighLights()
        }
    }
}

struct HighlightsView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightsView(vm: DashboardHighlightListViewModel())
    }
}
