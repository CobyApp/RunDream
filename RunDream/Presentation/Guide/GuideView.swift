//
//  GuideView.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

import CobyDS

struct GuideView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    VStack(spacing: 8) {
                        HStack {
                            Text("Run Dream!")
                                .font(.pretendard(size: 24, weight: .bold))
                                .foregroundColor(Color.labelNormal)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("다음과 같은 유의사항을 지켜주세요!")
                                .font(.pretendard(size: 17, weight: .regular))
                                .foregroundColor(Color.labelNeutral)
                            
                            Spacer()
                        }
                    }
                    
                    VStack(spacing: 30) {
                        VStack(spacing: 8) {
                            HStack {
                                Text("사용시간(남은시간)을 잘 입력해주세요.")
                                    .font(.pretendard(size: 16, weight: .semibold))
                                    .foregroundColor(Color.labelNormal)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("· 사용할 때마다 시간을 입력해주세요.")
                                    .font(.pretendard(size: 16, weight: .regular))
                                    .foregroundColor(Color.labelNormal)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("· 일부러 틀린 시간을 입력하지 말아주세요.")
                                    .font(.pretendard(size: 16, weight: .regular))
                                    .foregroundColor(Color.labelNormal)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("· 잘못 입력했을때, 취소하고 수정해주세요.")
                                    .font(.pretendard(size: 16, weight: .regular))
                                    .foregroundColor(Color.labelNormal)
                                
                                Spacer()
                            }
                        }
                        
                        VStack(spacing: 8) {
                            HStack {
                                Text("널리 홍보해주세요.")
                                    .font(.pretendard(size: 16, weight: .semibold))
                                    .foregroundColor(Color.labelNormal)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("· 모든 인원이 사용해야 앱이 원활해져요.")
                                    .font(.pretendard(size: 16, weight: .regular))
                                    .foregroundColor(Color.labelNormal)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("· 다른 반에도 소문내러 가주세요.")
                                    .font(.pretendard(size: 16, weight: .regular))
                                    .foregroundColor(Color.labelNormal)
                                
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.top, BaseSize.verticalPadding)
            }
            
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("확인")
            }
            .buttonStyle(
                CBButtonStyle(
                    buttonColor: Color.labelNormal
                )
            )
            .padding(.bottom, BaseSize.verticalPadding)
        }
        .padding(.horizontal, BaseSize.horizantalPadding)
    }
}

#Preview {
    GuideView()
        .loadCustomFonts()
}
