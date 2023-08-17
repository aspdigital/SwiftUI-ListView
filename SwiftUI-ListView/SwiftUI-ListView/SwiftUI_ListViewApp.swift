//
//  SwiftUI_ScrollViewApp.swift
//  SwiftUI-ScrollView
//
//  Created by Andy Peters on 8/16/23.
//

import SwiftUI

@main
struct SwiftUI_ListViewApp: App {
    
    @StateObject var entries = Names(key: "ListEntries")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(entries)
        }
    }
}
