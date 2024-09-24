//
//  DryerView.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

struct DryerView: View {
    
    var cellWidth: CGFloat
    var isDisabled: Bool
    var endedAt: Date
    
    var body: some View {
        VStack(spacing: 8) {
            Image(.dryer)
                .resizable()
                .frame(width: self.cellWidth, height: self.cellWidth)
                .grayscale(isDisabled ? 1.0 : 0.0)
                .opacity(isDisabled ? 0.5 : 1.0)
            
            TimerView(endedAt: self.endedAt, cellWidth: self.cellWidth)
        }
    }
}
