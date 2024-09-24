//
//  DryerView.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

struct DryerView: View {
    
    var cellWidth: CGFloat
    
    var body: some View {
        VStack(spacing: 8) {
            Image(.dryer)
                .resizable()
                .frame(width: self.cellWidth, height: 100)
            
            TimerView(time: "01:00", cellWidth: self.cellWidth)
        }
    }
}

#Preview {
    DryerView(cellWidth: 100)
}
