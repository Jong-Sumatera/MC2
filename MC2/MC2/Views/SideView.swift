//
//  SideView.swift
//  LearnUp
//
//  Created by Dewi Nurul Hamidah on 29/06/22.
//

import SwiftUI

struct SideView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination:DashboardView()) {
                    Label("Dashboard",systemImage: "house.fill")
                }
                NavigationLink(destination:HighlightView()) {
                    Label("Highlight",systemImage: "highlighter")
                }
                NavigationLink(destination:SettingView()) {
                    Label("Setting",systemImage: "gearshape.fill")
                }
            }
            .navigationTitle("Learn Up")
            
            DashboardView()
        }
    }
}

struct SideView_Previews: PreviewProvider {
    static var previews: some View {
        SideView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
