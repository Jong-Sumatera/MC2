//
//  SimilarItemView.swift
//  MC2
//
//  Created by Widya Limarto on 21/07/22.
//

import SwiftUI

struct SimilarItemView: View {
    var highlight: HighlightViewModel
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Image(systemName: "character.cursor.ibeam")
                        .resizable()
                        .frame(width: 22, height: 22, alignment: .center)
                }
                .background(.yellow)
            }
        }
    }
}

struct SimilarItemView_Previews: PreviewProvider {
    static var previews: some View {
        SimilarItemView(highlight: HighlightViewModel(highlight: Highlight(context: Highlight.context)))
    }
}
