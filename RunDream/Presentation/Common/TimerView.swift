//
//  TimerView.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

import CobyDS

struct TimerView: View {
    
    var time: String
    var cellWidth: CGFloat
    
    var body: some View {
        Text(self.time)
            .font(.pretendard(size: 17, weight: .medium))
            .foregroundColor(Color.labelNormal)
            .padding(.vertical, 4)
            .frame(width: self.cellWidth, alignment: .center)
            .background(Color.backgroundNormalNormal)
            .clipShape(.rect(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.lineNormalNeutral, lineWidth: 1)
            )
    }
}

#Preview {
    TimerView(time: "01:00", cellWidth: 100)
}
