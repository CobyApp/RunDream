//
//  WasherView.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

struct WasherView: View {
    
    var cellWidth: CGFloat
    var isDisabled: Bool
    var time: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(.washer)
                .resizable()
                .frame(width: self.cellWidth, height: self.cellWidth)
                .grayscale(isDisabled ? 1.0 : 0.0)
                .opacity(isDisabled ? 0.5 : 1.0)
            
            TimerView(time: self.time, cellWidth: self.cellWidth)
        }
    }
}
