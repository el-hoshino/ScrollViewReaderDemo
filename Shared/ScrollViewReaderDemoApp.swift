//
//  ScrollViewReaderDemoApp.swift
//  Shared
//
//  Created by 史 翔新 on 2021/04/22.
//

import SwiftUI

@main
struct ScrollViewReaderDemoApp: App {
    
    // Enable the method swizzling below if you want to check the bug in `scrollTo` method in SwiftUI
//    init() {
//        UITableView.swizzle()
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
