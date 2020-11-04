//
//  WhatsCookingApp.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 21/10/2020.
//

import SwiftUI

@main
struct WhatsCookingApp: App {
    let persistenceController = PersistenceController.shared

    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
