//
//  MainView.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

import CobyDS

struct MainView: View {
    
    @ObservedObject private var viewModel = MainViewModel()
    
    @State private var showSheet: Bool = false
    
    @State private var showingDryerAlert: Bool = false
    @State private var showingWasherAlert: Bool = false
    @State private var time: String = ""
    
    @State private var showingDryerCancelAlert: Bool = false
    @State private var showingWasherCancelAlert: Bool = false
    
    @State private var showingOutAlert: Bool = false
    
    @State private var selectedDryer: Dryer?
    @State private var selectedWasher: Washer?
    
    private let cellWidth: CGFloat = (BaseSize.fullWidth - 16) / 3
    
    private let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(
                barType: .filled,
                leftSide: .icon,
                leftIcon: UIImage(systemName: "questionmark.circle"),
                leftAction: {
                    self.showSheet = true
                },
                title: "Run Dream!",
                rightSide: .icon,
                rightIcon: UIImage(resource: .out),
                rightAction: {
                    self.showingOutAlert = true
                }
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
                            ForEach(self.viewModel.dryers, id: \.id) { dryer in
                                DryerView(
                                    cellWidth: self.cellWidth,
                                    isDisabled: dryer.endedAt > Date(),
                                    endedAt: dryer.endedAt
                                )
                                .onTapGesture {
                                    self.selectedDryer = dryer
                                    
                                    if dryer.endedAt > Date() {
                                        self.showingDryerCancelAlert = true
                                    } else {
                                        self.showingDryerAlert = true
                                    }
                                }
                            }
                            
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
                            ForEach(self.viewModel.washers, id: \.id) { washer in
                                WasherView(
                                    cellWidth: self.cellWidth,
                                    isDisabled: washer.endedAt > Date(),
                                    endedAt: washer.endedAt
                                )
                                .onTapGesture {
                                    self.selectedWasher = washer
                                    
                                    if washer.endedAt > Date() {
                                        self.showingWasherCancelAlert = true
                                    } else {
                                        self.showingWasherAlert = true
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(.vertical, BaseSize.verticalPadding)
                .padding(.horizontal, BaseSize.horizantalPadding)
            }
        }
        .sheet(isPresented: self.$showSheet) {
            GuideView()
        }
        .alert("건조기 시간", isPresented: self.$showingDryerAlert) {
            TextField(self.time, text: self.$time)
                .keyboardType(.numberPad)
            
            Button("확인", action: {
                if let minutes = Int(self.time), let dryer = self.selectedDryer {
                    let currentTime = Date()
                    if let newEndTime = Calendar.current.date(byAdding: .minute, value: minutes, to: currentTime) {
                        self.viewModel.updateDryerEndedAt(dryer: dryer, newEndedAt: newEndTime)
                    }
                    self.selectedDryer = nil
                    self.time = ""
                }
            })
            
            Button("취소", role: .cancel, action: {
                self.selectedDryer = nil
                self.time = ""
            })
        } message: {
            Text("사용시간(남은시간)을 분단위로 입력해주세요")
        }
        .alert("세탁기 시간", isPresented: self.$showingWasherAlert) {
            TextField(self.time, text: self.$time)
                .keyboardType(.numberPad)
            
            Button("확인", action: {
                if let minutes = Int(self.time), let washer = self.selectedWasher {
                    let currentTime = Date()
                    if let newEndTime = Calendar.current.date(byAdding: .minute, value: minutes, to: currentTime) {
                        self.viewModel.updateWasherEndedAt(washer: washer, newEndedAt: newEndTime)
                    }
                    self.selectedWasher = nil
                    self.time = ""
                }
            })
            
            Button("취소", role: .cancel, action: {
                self.selectedWasher = nil
                self.time = ""
            })
        } message: {
            Text("사용시간(남은시간)을 분단위로 입력해주세요")
        }
        .alert("건조기 시간", isPresented: self.$showingDryerCancelAlert) {
            Button("확인", action: {
                if let dryer = self.selectedDryer {
                    self.viewModel.updateDryerEndedAt(dryer: dryer, newEndedAt: Date())
                    self.selectedDryer = nil
                }
            })
            
            Button("취소", role: .cancel, action: {
                self.selectedDryer = nil
            })
        } message: {
            Text("건조기 시간을 잘못 입력했거나, 사용을 중단하시겠습니까?")
        }
        .alert("세탁기 시간", isPresented: self.$showingWasherCancelAlert) {
            Button("확인", action: {
                if let washer = self.selectedWasher {
                    self.viewModel.updateWasherEndedAt(washer: washer, newEndedAt: Date())
                    self.selectedWasher = nil
                }
            })
            
            Button("취소", role: .cancel, action: {
                self.selectedWasher = nil
            })
        } message: {
            Text("세탁기 시간을 잘못 입력했거나, 사용을 중단하시겠습니까?")
        }
        .alert("그룹 나가기", isPresented: self.$showingOutAlert) {
            Button("확인", action: {
                self.viewModel.teamId = ""
            })
            
            Button("취소", role: .cancel, action: {})
        } message: {
            Text("그룹을 나가시겠습니까?")
        }
    }
}

#Preview {
    MainView()
        .loadCustomFonts()
}
