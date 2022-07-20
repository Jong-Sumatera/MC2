//
//  SwiftUIView.swift
//  MC2
//
//  Created by Clara Evangeline on 29/06/22.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    init() {
        /// These could be anywhere before the list has loaded.
        UITableView.appearance().backgroundColor = .clear // tableview background
        UITableViewCell.appearance().backgroundColor = .clear // cell background
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.secondaryColor)]
        
        UINavigationBar.appearance().barTintColor    = UIColor.white
//
    }
    
    var body: some View {
        SideView(selection: 0)
            .onAppear{
                UserDefaults.standard.set(false, forKey: "onboarding")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
