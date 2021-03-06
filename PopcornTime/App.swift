//
//  PopcornTimetvOS_SwiftUIApp.swift
//  PopcornTimetvOS SwiftUI
//
//  Created by Alexandru Tudose on 19.06.2021.
//  Copyright © 2021 PopcornTime. All rights reserved.
//

import SwiftUI
import PopcornKit


@main
struct PopcornTime: App {
    @State var tosAccepted = Session.tosAccepted
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if !tosAccepted {
                    TermsOfServiceView(tosAccepted: $tosAccepted)
                } else {
                    TabBarView()
                    #if os(iOS) || os(macOS)
                        .modifier(MagnetTorrentLinkOpener())
                    #elseif os(tvOS)
                        .modifier(TopShelfLinkOpener())
                    #endif
                }
            }
            .preferredColorScheme(.dark)
            #if os(iOS)
            .accentColor(.white)
            .navigationViewStyle(StackNavigationViewStyle())
            #endif
//            .onAppear {
//                TraktManager.shared.syncUserData()
//            }
        }
//        #if os(iOS) || os(macOS)
//        .commands(content: {
//            OpenCommand()
//        })
//        #endif
//        .windowStyle(.hiddenTitleBar)
//        .windowToolbarStyle(.unified(showsTitle: false))
        
        #if os(macOS)
//        Settings {
//            SettingsView()
//        }
        #endif
    }

// in order do exit app on window close
#if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate
    
    final class AppDelegate: NSObject, NSApplicationDelegate {
        func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
            true
        }
    }
#endif
}
