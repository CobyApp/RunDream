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
}
