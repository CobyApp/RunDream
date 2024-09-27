//
//  MainViewModel.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import SwiftUI

import Firebase
import FirebaseFirestore

class MainViewModel: ObservableObject {
    
    @AppStorage("teamId") var teamId: String = ""
    
    @Published var dryers: [Dryer] = []
    @Published var washers: [Washer] = []
    
    private var dryerListener: ListenerRegistration?
    private var washerListener: ListenerRegistration?
    
    init() {
        self.fetchDryers()
        self.fetchWashers()
        self.addDryersListener()
        self.addWashersListener()
    }
    
    deinit {
        self.dryerListener?.remove()
        self.washerListener?.remove()
    }
    
    // Firestore에서 특정 팀의 건조기 데이터를 가져오는 함수
    func fetchDryers() {
        guard !teamId.isEmpty else {
            print("No teamId found.")
            return
        }
        
        FirebaseManager.shared.firestore
            .collection("team")
            .document(teamId)
            .collection("dryer")  // 'dryers'에서 'dryer'로 수정
            .order(by: "number")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching dryers: \(error.localizedDescription)")
                    return
                }
                
                self.dryers = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Dryer.self)
                } ?? []
                
                print("Fetched \(self.dryers.count) dryers.")
            }
    }
    
    // Firestore에서 특정 팀의 세탁기 데이터를 가져오는 함수
    func fetchWashers() {
        guard !teamId.isEmpty else {
            print("No teamId found.")
            return
        }
        
        FirebaseManager.shared.firestore
            .collection("team")
            .document(teamId)
            .collection("washer")
            .order(by: "number")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching washers: \(error.localizedDescription)")
                    return
                }
                
                self.washers = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Washer.self)
                } ?? []
                
                print("Fetched \(self.washers.count) washers.")
            }
    }
    
    // 실시간 업데이트를 위한 건조기 listener 설정
    func addDryersListener() {
        guard !teamId.isEmpty else {
            print("No teamId found.")
            return
        }
        
        self.dryerListener?.remove()
        self.dryerListener = FirebaseManager.shared.firestore
            .collection("team")
            .document(teamId)
            .collection("dryer")
            .order(by: "number")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print(error)
                    return
                }
                
                querySnapshot?.documentChanges.forEach { change in
                    if change.type == .modified {
                        if let updatedDryer = try? change.document.data(as: Dryer.self) {
                            self.updateItem(in: &self.dryers, with: updatedDryer) { $0.number == $1.number }
                        }
                    }
                }
            }
    }
    
    // 실시간 업데이트를 위한 세탁기 listener 설정
    func addWashersListener() {
        guard !teamId.isEmpty else {
            print("No teamId found.")
            return
        }
        
        self.washerListener?.remove()
        self.washerListener = FirebaseManager.shared.firestore
            .collection("team")
            .document(teamId)
            .collection("washer")
            .order(by: "number")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print(error)
                    return
                }
                
                querySnapshot?.documentChanges.forEach { change in
                    if change.type == .modified {
                        if let updatedWasher = try? change.document.data(as: Washer.self) {
                            self.updateItem(in: &self.washers, with: updatedWasher) { $0.number == $1.number }
                        }
                    }
                }
            }
    }
    
    func updateDryerEndedAt(dryer: Dryer, newEndedAt: Date) {
        guard let documentId = dryer.id else {
            print("Dryer document ID is missing.")
            return
        }
        
        // Firestore 참조 가져오기
        let dryerRef = FirebaseManager.shared.firestore
            .collection("team")
            .document(teamId)
            .collection("dryer")
            .document(documentId)
        
        // Firestore에 endedAt 필드 업데이트
        dryerRef.updateData([
            "endedAt": newEndedAt
        ]) { error in
            if let error = error {
                print("Error updating endedAt: \(error.localizedDescription)")
            } else {
                // 로컬 데이터도 업데이트
                if let index = self.dryers.firstIndex(where: { $0.number == dryer.number }) {
                    self.dryers[index].endedAt = newEndedAt
                }
            }
        }
    }

    func updateWasherEndedAt(washer: Washer, newEndedAt: Date) {
        guard let documentId = washer.id else {
            print("Washer document ID is missing.")
            return
        }
        
        // Firestore 참조 가져오기
        let washerRef = FirebaseManager.shared.firestore
            .collection("team")
            .document(teamId)
            .collection("washer")
            .document(documentId)
        
        // Firestore에 endedAt 필드 업데이트
        washerRef.updateData([
            "endedAt": newEndedAt
        ]) { error in
            if let error = error {
                print("Error updating endedAt for washer: \(error.localizedDescription)")
            } else {
                // 로컬 데이터도 업데이트
                if let index = self.washers.firstIndex(where: { $0.number == washer.number }) {
                    self.washers[index].endedAt = newEndedAt
                }
                print("Washer endedAt successfully updated.")
            }
        }
    }
    
    // 배열에서 항목을 업데이트하거나 추가하는 공통 함수
    func updateItem<T: Identifiable & Equatable>(in array: inout [T], with newItem: T, match: (T, T) -> Bool) {
        if let index = array.firstIndex(where: { match($0, newItem) }) {
            array[index] = newItem
        } else {
            array.append(newItem)
        }
    }
}
