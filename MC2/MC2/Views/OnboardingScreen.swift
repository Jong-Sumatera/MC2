//
//  OnboardingScreen.swift
//  MC2
//
//  Created by Dewi Nurul Hamidah on 04/07/22.
//

import SwiftUI

struct OnboardingScreen: View {
    var body: some View {
        
        NavigationView {
            VStack{
                Text("**Our Feature**")
                    .frame(width: 500, height: 100, alignment: .center)
                    .font(.system(size: 40))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("primaryColor"))
                    .padding()
                
                HStack{
                    Image(systemName: "highlighter")
                        .font(.system(size: 55))
                      //  .frame(width: 100, height: 100)
                        .foregroundColor(Color("primaryColor"))
                        .padding()
                        .frame(width:105, alignment: .center)
                    
                    VStack(alignment:.leading, spacing: 5.0){
                        Text ("Highlight")
                            .font(.system(size: 25))
                            .bold()
                            .foregroundColor(Color("primaryColor"))
                            .frame(width: 500,  alignment: .leading)
                        
                        Text ("""
                            You can highlight words, sentences, paragraphs that you want to mark as important
                            """)
                            .font(.system(size: 19))
                            .foregroundColor(Color.gray)
                            .frame(width: 500,alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .padding(.trailing,10)
                    }
                }
//                }.frame(width: 705, alignment: .center)
//                 .padding(.top,40)
                
                HStack{
                    Image(systemName: "text.bubble")
                        .font(.system(size: 55))
                      //  .frame(width: 100, height: 100)
                        .foregroundColor(Color("primaryColor"))
                        .padding()
                        .frame(width:105, alignment: .center)
                    
                    VStack(alignment:.leading, spacing: 5.0){
                        Text ("Comment")
                            .font(.system(size: 25))
                            .bold()
                            .foregroundColor(Color("primaryColor"))
                            .frame(width: 500,  alignment: .leading)
                        
                        Text ("You can provide explanations or comments on the words, sentences, and paragraphs that you have marked so that you can understand them better")
                            .font(.system(size: 19))
                            .foregroundColor(Color.gray)
                            .frame(width: 500,alignment: .leading)
                            .padding(.trailing,15)
                    }
                }
                
                HStack{
                    Image(systemName: "tag")
                        .font(.system(size: 55))
                      //  .frame(width: 100, height: 100)
                        .foregroundColor(Color("primaryColor"))
                        .padding()
                        .frame(width:105, alignment: .center)
                    
                    VStack(alignment:.leading, spacing: 5.0){
                        Text ("Tags")
                            .font(.system(size: 25))
                            .bold()
                            .foregroundColor(Color("primaryColor"))
                            .frame(width: 500,  alignment: .leading)
                        
                        Text ("You can mark words, sentences and paragraphs that you highlight by putting a (#) sign at the beginning of the tag in the comments so that you can find them more easily.")
                            .font(.system(size: 19))
                            .foregroundColor(Color.gray)
                            .frame(width: 500,alignment: .leading)
                            .padding(.trailing,15)
                    }
                }
                HStack{
                    Image(systemName: "character.book.closed.fill")
                        .font(.system(size: 55))
                      //  .frame(width: 100, height: 100)
                        .foregroundColor(Color("primaryColor"))
                        .padding()
                        .frame(width:105, alignment: .center)
                    
                    VStack(alignment:.leading, spacing: 5.0){
                        Text ("Translate")
                            .font(.system(size: 25))
                            .bold()
                            .foregroundColor(Color("primaryColor"))
                            .frame(width: 500,  alignment: .leading)
                        
                        Text ("We provide a translate to Bahasa feature so you can find the meaning of the word in Bahasa")
                            .font(.system(size: 19))
                            .foregroundColor(Color.gray)
                            .frame(width: 500,alignment: .leading)
                            .padding(.trailing,15)
                    }
                }
//                }.frame(width: 705, alignment: .center)
//                 .padding(.bottom,150)
                Spacer()
                
                NavigationLink(destination: ContentView()) {
                    PrimaryButton(text: "Get Started")
                }
                Spacer()
            }
            
        }.navigationViewStyle(.stack)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            
        
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
            .previewInterfaceOrientation(.portrait)
    }
}
