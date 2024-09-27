//
//  MakeView.swift
//  RunDream
//
//  Created by Coby on 9/27/24.
//

import SwiftUI

import CobyDS

struct MakeView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var viewModel = MakeViewModel()
    
    @State private var name: String = ""
    @State private var code: String = ""
    @State private var dryerCount: String = ""
    @State private var washerCount: String = ""
    
    private var isDisabled: Bool {
        self.name == "" || self.code == "" || self.dryerCount == "" || self.washerCount == ""
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(
                barType: .filled,
                leftSide: .title,
                leftTitle: "그룹 만들기"
            )
            
            ScrollView(showsIndicators: false) {
                VStack {
                    CBTextFieldView(
                        text: self.$name,
                        textFieldContentsType: .primary,
                        textFieldTrailing: .none,
                        textFieldSize: .large,
                        isFilled: true,
                        title: "그룹 이름",
                        placeholder: "그룹 이름을 입력해주세요."
                    )
                    .padding(.top, BaseSize.verticalPadding)
                    
                    CBTextFieldView(
                        text: self.$code,
                        textFieldContentsType: .primary,
                        textFieldTrailing: .none,
                        textFieldSize: .large,
                        isFilled: true,
                        title: "입장 코드",
                        placeholder: "입장 코드를 설정해주세요."
                    )
                    .padding(.top, BaseSize.verticalPadding)
                    
                    CBTextFieldView(
                        text: self.$dryerCount,
                        textFieldContentsType: .number,
                        textFieldTrailing: .none,
                        textFieldSize: .large,
                        isFilled: true,
                        title: "건조기 수량",
                        placeholder: "건조기 수량을 입력해주세요."
                    )
                    .padding(.top, BaseSize.verticalPadding)
                    
                    CBTextFieldView(
                        text: self.$washerCount,
                        textFieldContentsType: .number,
                        textFieldTrailing: .none,
                        textFieldSize: .large,
                        isFilled: true,
                        title: "세탁기 수량",
                        placeholder: "세탁기 수량을 입력해주세요."
                    )
                    .padding(.top, BaseSize.verticalPadding)
                    
                    Spacer()
                }
                .padding(.horizontal, BaseSize.horizantalPadding)
            }
            
            Spacer()
            
            Button {
                if !self.isDisabled {
                    self.viewModel.addTeam(
                        name: self.name,
                        code: self.code,
                        dryCount: Int(self.dryerCount) ?? 1,
                        washerCount: Int(self.washerCount) ?? 1
                    )
                    
                    self.dismiss()
                }
            } label: {
                Text("완료")
            }
            .buttonStyle(
                CBButtonStyle(
                    isDisabled: self.isDisabled,
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

#Preview {
    MakeView()
}
