//
//  MainView.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

import CobyDS

struct MainView: View {
    
    private let cellWidth: CGFloat = (BaseSize.fullWidth - 16) / 3
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(
                barType: .filled,
                leftSide: .title,
                leftTitle: "Run Dream!"
            )
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    VStack(spacing: 20) {
                        HStack {
                            Text("건조기")
                                .font(.pretendard(size: 18, weight: .semibold))
                                .foregroundColor(Color.labelNormal)
                            
                            Spacer()
                        }
                        
                        HStack(spacing: 8) {
                            DryerView(cellWidth: self.cellWidth)
                            
                            DryerView(cellWidth: self.cellWidth)
                            
                            Spacer()
                        }
                    }
                    
                    VStack(spacing: 20) {
                        HStack {
                            Text("세탁기")
                                .font(.pretendard(size: 18, weight: .semibold))
                                .foregroundColor(Color.labelNormal)
                            
                            Spacer()
                        }
                        
                        HStack(spacing: 8) {
                            WasherView(cellWidth: self.cellWidth)
                            
                            WasherView(cellWidth: self.cellWidth)
                            
                            WasherView(cellWidth: self.cellWidth)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.vertical, BaseSize.verticalPadding)
                .padding(.horizontal, BaseSize.horizantalPadding)
            }
        }
    }
}

#Preview {
    MainView()
}
