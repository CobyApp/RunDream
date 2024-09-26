//
//  LaunchView.swift
//  RunDream
//
//  Created by Coby on 9/26/24.
//

import SwiftUI

import CobyDS

struct LaunchView: View {
    
    @State private var isPassed: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: 40) {
                    VStack(spacing: 16) {
                        VStack(spacing: 12) {
                            HStack {
                                Text("Run Dream!")
                                    .font(.pretendard(size: 24, weight: .bold))
                                    .foregroundColor(Color.labelNormal)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("건조기/세탁기 스케쥴링 서비스")
                                    .font(.pretendard(size: 16, weight: .regular))
                                    .foregroundColor(Color.labelNeutral)
                                
                                Spacer()
                            }
                        }
                        
                        HStack {
                            Text("문의 사항은 coby5502@gmail.com으로 보내주세요.")
                                .font(.pretendard(size: 14, weight: .regular))
                                .foregroundColor(Color.labelNeutral)
                            
                            Spacer()
                        }
                    }
                    .padding(.top, BaseSize.verticalPadding)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("그룹 목록")
                                .font(.pretendard(size: 16, weight: .bold))
                                .foregroundColor(Color.labelNormal)
                            
                            Spacer()
                        }
                        
                        ScrollView(showsIndicators: false) {
                            HStack {
                                VStack(spacing: 8) {
                                    HStack {
                                        Text("신한 GYC 6기")
                                            .font(.pretendard(size: 14, weight: .medium))
                                            .foregroundColor(Color.labelNormal)
                                        
                                        Spacer()
                                    }
                                    
                                    Image(uiImage: .gyc)
                                        .resizable()
                                        .frame(width: 85, height: 20)
                                    
                                    Spacer()
                                }
                                .padding(14)
                                .frame(width: BaseSize.cellWidth, height: 80)
                                .background(Color.backgroundNormalNormal)
                                .clipShape(.rect(cornerRadius: 12))
                                .contentShape(Rectangle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.lineNormalNeutral, lineWidth: 1)
                                )
                                .onTapGesture {
                                    self.isPassed = true
                                }
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }
                        .padding(.vertical, 12)
                    }
                }
            }
            .padding(.horizontal, BaseSize.horizantalPadding)
            .navigationDestination(isPresented: self.$isPassed) {
                EntranceView()
                    .navigationBarHidden(true)
            }
        }
    }
}

#Preview {
    LaunchView()
        .loadCustomFonts()
}
