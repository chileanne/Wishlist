//
//  WishlistApp.swift
//  Wishlist
//
//  Created by user on 1/8/25.
//

import SwiftUI
import SwiftData

@main
struct WishlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for : Wish.self)
        }
    }
}
