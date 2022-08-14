//
//  HighlightCellView.swift
//  MC2
//
//  Created by Widya Limarto on 18/07/22.
//

import SwiftUI

struct HighlightCellView: View {
    @Binding var highlightVM: HighlightViewModel
    @Binding var selectedId: UUID?
    @State var isShowDetail : Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation{
                    isShowDetail.toggle()
                }
                
            }, label: {
                HStack{
                    VStack{
                        Image(systemName: "character.cursor.ibeam")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(.black)
                    }
                    .padding(.all, 8)
                    .background(Color(highlightVM.color))
                    .cornerRadius(10)
                    Text(highlightVM.text)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.textColor)
                        .font(Font.body.bold())
                    Spacer()
                    Image(systemName: "chevron.down")
                        .frame(width: 24, height: 22)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.lightBlueColor)
                        .scaleEffect(CGSize(width: 1.0, height: isShowDetail ? -1.0: 1.0))
                    
                }
            })
            
            if isShowDetail {
                HighlightDetailView(highlightVM: highlightVM, color: Color(highlightVM.color)
//                                    ,isShowOnWatch: highlightVM.isShowOnWatch
                )
            }
            
        }
        .padding(.all, 8)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(Color.highlightBoxColor))
        .compositingGroup()
        .shadow(color: Color.shadowColor, radius: 3, x: 2, y: 2)
        .onChange(of: selectedId, perform: { i in
            if(i == highlightVM.highlightId){
                withAnimation{
                    self.isShowDetail = true
                }
                selectedId = nil
            }
        })
        .onAppear{
            if (selectedId == highlightVM.highlightId){
                withAnimation{
                    self.isShowDetail = true
                }
                selectedId = nil
            }
        }
        
        
        
    }
}

struct HighlightCellView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightCellView(highlightVM: .constant(HighlightViewModel(highlight: Highlight(context: Highlight.context))), selectedId: .constant(nil))
    }
}
    
