//
//  ContentView.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

import CobyDS

struct ContentView: View {
    
    @AppStorage("isPassed") private var isPassed: Bool = false
    
    var body: some View {
        Group {
            if self.isPassed {
                MainView()
            } else {
                LaunchView()
            }
        }        
        .loadCustomFonts()
    }
}

#Preview {
    ContentView()
}
