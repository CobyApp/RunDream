//
//  View+Extensions.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

extension View {
    
    func closeKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func getRemainingTimeString(from endedAt: Date) -> String {
        let currentTime = Date()
        
        // 남은 시간이 endedAt보다 작거나 같으면 "00:00" 반환
        if endedAt <= currentTime {
            return "00:00"
        }
        
        // 현재 시간과 endedAt의 차이를 초 단위로 계산
        let timeDifference = Int(endedAt.timeIntervalSince(currentTime))
        
        // 시와 분으로 변환, 초가 있으면 올림 처리
        let hours = timeDifference / 3600
        let minutes = Int(ceil(Double(timeDifference % 3600) / 60.0))  // 올림 처리
        
        // "00:00" 형식으로 반환
        return String(format: "%02d:%02d", hours, minutes)
    }
}
