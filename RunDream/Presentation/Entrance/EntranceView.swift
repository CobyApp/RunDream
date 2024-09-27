//
//  EntranceView.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

import CobyDS

struct EntranceView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var verifiedCode: String
    @Binding var id: String
    
    @State private var code: String = ""
    @State private var textFieldState: TextFieldState = .enabled
    
    @AppStorage("teamId") private var teamId: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(
                leftAction: {
                    self.dismiss()
                },
                title: "그룹 입장"
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
                    self.teamId = self.id
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
    }
}
