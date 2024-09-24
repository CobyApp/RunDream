//
//  LaunchView.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

import CobyDS

struct LaunchView: View {
    
    @State private var code: String = ""
    @State private var textFieldState: TextFieldState = .enabled
    @State private var isPassed: Bool = false
    
    @AppStorage("isPassed") private var isPassedUser: Bool = false
    
    private var verifiedCode: String = "gyc6기"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 40) {
                        VStack(spacing: 8) {
                            HStack {
                                Text("Run Dream!")
                                    .font(.pretendard(size: 24, weight: .semibold))
                                    .foregroundColor(Color.labelNormal)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("신한 GYC 세탁기 스케쥴링 서비스")
                                    .font(.pretendard(size: 17, weight: .regular))
                                    .foregroundColor(Color.labelNeutral)
                                
                                Spacer()
                            }
                        }
                        .padding(.top, BaseSize.verticalPadding)
                        
                        CBTextFieldView(
                            text: self.$code,
                            textFieldState: self.$textFieldState,
                            textFieldContentsType: .primary,
                            textFieldTrailing: .none,
                            textFieldSize: .large,
                            isFilled: true,
                            title: "입장 코드",
                            placeholder: "입장 코드를 입력해주세요.",
                            errorMessage: "올바른 코드를 입력해주세요."
                        )
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                Button {
                    if self.code == self.verifiedCode {
                        self.isPassedUser = true
                        self.isPassed = true
                    } else {
                        self.textFieldState = .error
                    }
                } label: {
                    Text("다음")
                }
                .buttonStyle(
                    CBButtonStyle(
                        isDisabled: self.code.count == 0 || self.textFieldState == .error,
                        buttonColor: Color.black
                    )
                )
                .padding(.bottom, BaseSize.verticalPadding)
            }
            .padding(.horizontal, BaseSize.horizantalPadding)
            .onTapGesture {
                self.closeKeyboard()
            }
            .navigationDestination(isPresented: self.$isPassed) {
                GuideView()
                    .navigationBarHidden(true)
            }
        }
    }
}

#Preview {
    LaunchView()
        .loadCustomFonts()
}
