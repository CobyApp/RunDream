//
//  ContentView.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

import CobyDS

struct ContentView: View {
    
    @AppStorage("teamId") private var teamId: String = ""
    
    var body: some View {
        Group {
            if self.teamId == "" {
                LaunchView()
            } else {
                MainView()
            }
        }        
        .loadCustomFonts()
        .background(Color.backgroundNormalNormal)
    }
}

#Preview {
    ContentView()
}
