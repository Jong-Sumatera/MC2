//
//  PrimaryButton.swift
//  MC2
//
//  Created by Dewi Nurul Hamidah on 04/07/22.
//

import SwiftUI

struct PrimaryButton : View {
    var text : String
    var background: Color = Color("primaryColor")
    
    var body: some View {
        Text(text)
            .font(.system(size: 35))
            .frame(width: 250, height: 40, alignment: .center)
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal)
            .background(background)
            .cornerRadius(30)
            .shadow(radius: 10)
        
    }
}

struct PrimaryButton_Preview: PreviewProvider {
    static var previews: some View{
        PrimaryButton(text: "Next")
            .font(.system(size: 40))
    }
}
