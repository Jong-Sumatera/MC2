//
//  DashboardView.swift
//  LearnUp
//
//  Created by Dewi Nurul Hamidah on 29/06/22.
//

import SwiftUI
import UIKit

struct DashboardVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboard = UIStoryboard(name: "Dashboard", bundle: Bundle.main)
                let controller = storyboard.instantiateViewController(identifier: "dashboard")
                return controller
            }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct DashboardView: View {
    var body: some View {
        DashboardVCRepresentable().ignoresSafeArea()
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView()
                .previewInterfaceOrientation(.landscapeLeft)
            DashboardView()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
