//
//  SimilarItemView.swift
//  MC2
//
//  Created by Widya Limarto on 21/07/22.
//

import SwiftUI

struct SimilarItemView: View {
    var highlight: HighlightViewModel
    @State var goToHome: Bool = false
    
    @EnvironmentObject var activeScreen: ActiveScreenViewModel
    var body: some View {
        VStack{
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
                    Text(.init("\(highlight.text)"))
                    Text("\(highlight.fileName)")
                        .font(.system(size: 10))
                        .fontWeight(.semibold)
                        .italic()
                        .foregroundColor(.gray)
                    VStack{
                        ForEach(highlight.notes, id: \.noteId) { note in
                            VStack(alignment: .leading){
                                Text(.init("\(note.text)\(Helper.tagsToString(tags: note.tags))"))
                                    .environment(\.openURL, OpenURLAction { url in
                                        activeScreen.screen = "#\(url.fragment!)"
                                        return .handled
                                    })
                                    .textSelection(.enabled)
                                Text("Last modified \(note.modifiedDate.formattedDate)")
                                    .font(.system(size: 10))
                                    .italic()
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 10)
                                Divider().padding(.top, 5)
                            }
                            
                        }
                    }
                    .padding(.top, 10)
                    NavigationLink(destination: DashboardView(), isActive: $goToHome, label: {}).hidden()
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 10)
    }

    
}

struct SimilarItemView_Previews: PreviewProvider {
    static var previews: some View {
        SimilarItemView(highlight: HighlightViewModel(highlight: Highlight(context: Highlight.context)))
    }
}
