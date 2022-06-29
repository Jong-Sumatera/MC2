//
//  MC2App.swift
//  MC2
//
//  Created by Clara Evangeline on 29/06/22.
//

import SwiftUI

@main
struct MC2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
