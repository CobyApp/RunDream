//
//  MakeViewModel.swift
//  RunDream
//
//  Created by Coby on 9/27/24.
//

import SwiftUI

import Firebase
import FirebaseFirestore

class MakeViewModel: ObservableObject {
    
    func addTeam(name: String, code: String, dryCount: Int, washerCount: Int) {
        // Firestore에 새로운 그룹 추가
        let teamRef = FirebaseManager.shared.firestore
            .collection("team")
            .document()  // 자동 생성된 documentId 사용
        
        let teamData: [String: Any] = [
            "name": name,
            "code": code,
            "dryerCount": dryCount,
            "washerCount": washerCount
        ]
        
        // 그룹 데이터를 추가
        teamRef.setData(teamData) { error in
            if let error = error {
                print("Error creating team: \(error.localizedDescription)")
                return
            }
            
            print("Team successfully created")
            
            // 건조기 및 세탁기 추가
            self.addDryersAndWashers(to: teamRef, dryCount: dryCount, washerCount: washerCount)
        }
    }
    
    // 건조기와 세탁기를 그룹 하위에 추가하는 함수
    private func addDryersAndWashers(to teamRef: DocumentReference, dryCount: Int, washerCount: Int) {
        let batch = FirebaseManager.shared.firestore.batch()  // 배치로 처리하여 일괄 저장
        
        // 건조기 추가
        let dryersCollectionRef = teamRef.collection("dryer")
        for i in 1...dryCount {
            let dryerData: [String: Any] = [
                "number": i,
                "endedAt": Date()
            ]
            let dryerRef = dryersCollectionRef.document()  // 자동으로 ID 생성
            batch.setData(dryerData, forDocument: dryerRef)
        }
        
        // 세탁기 추가
        let washersCollectionRef = teamRef.collection("washer")
        for i in 1...washerCount {
            let washerData: [String: Any] = [
                "number": i,
                "endedAt": Date()
            ]
            let washerRef = washersCollectionRef.document()  // 자동으로 ID 생성
            batch.setData(washerData, forDocument: washerRef)
        }
        
        // 배치 커밋 (한번에 Firestore에 저장)
        batch.commit { error in
            if let error = error {
                print("Error adding dryers and washers: \(error.localizedDescription)")
            } else {
                print("Dryers and washers successfully added to team")
            }
        }
    }
}

