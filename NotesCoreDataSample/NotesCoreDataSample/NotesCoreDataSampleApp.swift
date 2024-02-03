//
//  NotesCoreDataSampleApp.swift
//  NotesCoreDataSample
//
//  Created by rfsouto on 3/2/24.
//

import SwiftUI

@main
struct NotesCoreDataSampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
