//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Tien Bui on 11/4/2023.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
