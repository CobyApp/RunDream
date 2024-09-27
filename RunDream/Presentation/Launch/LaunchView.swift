//
//  LaunchView.swift
//  RunDream
//
//  Created by Coby on 9/26/24.
//

import SwiftUI

import CobyDS

struct LaunchView: View {
    
    @ObservedObject private var viewModel = LaunchViewModel()
    
    @State private var isPassed: Bool = false
    @State private var showSheet: Bool = false
    
    @State private var verifiedCode: String = ""
    @State private var teamId: String = ""
    
    private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: 40) {
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
                    .padding(.top, BaseSize.verticalPadding)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("그룹 목록")
                                .font(.pretendard(size: 16, weight: .bold))
                                .foregroundColor(Color.labelNormal)
                            
                            Spacer()
                            
                            Image(.plus)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .onTapGesture {
                                    self.showSheet = true
                                }
                        }
                        
                        if self.viewModel.teams.count == 0 {
                            VStack {
                                Spacer()
                                
                                Text("생성된 그룹이 없습니다.")
                                    .font(.pretendard(size: 14, weight: .medium))
                                    .foregroundColor(Color.labelNormal)
                                
                                Spacer()
                            }
                            .padding(.vertical, 12)
                        } else {
                            ScrollView(showsIndicators: false) {
                                LazyVGrid(columns: self.columns) {
                                    ForEach(self.viewModel.teams, id: \.self) { team in
                                        VStack(spacing: 8) {
                                            HStack {
                                                Text(team.name)
                                                    .font(.pretendard(size: 16, weight: .medium))
                                                    .foregroundColor(Color.labelNormal)
                                                
                                                Spacer()
                                            }
                                            
                                            VStack(spacing: 4) {
                                                HStack {
                                                    Text("건조기: \(team.dryerCount)대")
                                                        .font(.pretendard(size: 14, weight: .regular))
                                                        .foregroundColor(Color.labelNormal)
                                                    
                                                    Spacer()
                                                }
                                                
                                                HStack {
                                                    Text("세탁기: \(team.washerCount)대")
                                                        .font(.pretendard(size: 14, weight: .regular))
                                                        .foregroundColor(Color.labelNormal)
                                                    
                                                    Spacer()
                                                }
                                            }
                                        }
                                        .padding(14)
                                        .frame(width: BaseSize.cellWidth)
                                        .background(Color.backgroundNormalNormal)
                                        .clipShape(.rect(cornerRadius: 12))
                                        .contentShape(Rectangle())
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.lineNormalNeutral, lineWidth: 1)
                                        )
                                        .onTapGesture {
                                            self.verifiedCode = team.code
                                            self.teamId = team.id ?? ""
                                            self.isPassed = true
                                        }
                                    }
                                }
                                .padding(.vertical, 12)
                                
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, BaseSize.horizantalPadding)
            .sheet(isPresented: self.$showSheet, onDismiss: {
                self.viewModel.fetchTeams()
            }) {
                MakeView()
            }
            .navigationDestination(isPresented: self.$isPassed) {
                EntranceView(
                    verifiedCode: self.$verifiedCode,
                    id: self.$teamId
                )
                .navigationBarHidden(true)
            }
        }
    }
}

#Preview {
    LaunchView()
        .loadCustomFonts()
}
