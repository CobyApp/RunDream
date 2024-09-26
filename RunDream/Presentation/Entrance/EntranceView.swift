//
//  EntranceView.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

import CobyDS

struct EntranceView: View {
    
    @State private var code: String = ""
    @State private var textFieldState: TextFieldState = .enabled
    @State private var isPassed: Bool = false
    
    @AppStorage("isPassed") private var isPassedUser: Bool = false
    
    private var verifiedCode: String = "gyc6기"
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(
                leftAction: {
                    
                },
                title: "방 입장"
            )
            
            ScrollView(showsIndicators: false) {
                VStack {
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
                    .padding(.top, BaseSize.verticalPadding)
                    
                    Spacer()
                }
                .padding(.horizontal, BaseSize.horizantalPadding)
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
                    buttonColor: Color.labelNormal
                )
            )
            .padding(.bottom, BaseSize.verticalPadding)
            .padding(.horizontal, BaseSize.horizantalPadding)
        }
        .onTapGesture {
            self.closeKeyboard()
        }
        .navigationDestination(isPresented: self.$isPassed) {
            GuideView()
                .navigationBarHidden(true)
        }
    }
}

#Preview {
    EntranceView()
        .loadCustomFonts()
}
