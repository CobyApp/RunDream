//
//  TimerView.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

import CobyDS

struct TimerView: View {
    
    @State private var currentTime: String = ""
    
    var endedAt: Date
    var cellWidth: CGFloat
    
    var time: String {
        self.getRemainingTimeString(from: self.endedAt)
    }
    
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(self.currentTime)
            .font(.pretendard(size: 17, weight: .regular))
            .foregroundColor(Color.labelNormal)
            .padding(.vertical, 4)
            .frame(width: self.cellWidth, alignment: .center)
            .background(Color.backgroundNormalNormal)
            .clipShape(.rect(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.lineNormalNeutral, lineWidth: 1)
            )
            .onAppear {
                // Initial time setup
                self.currentTime = self.time
            }
            .onReceive(timer) { _ in
                // Update time every 10 seconds
                self.currentTime = self.time
            }
    }
}
