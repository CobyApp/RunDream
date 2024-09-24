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
    
    func fetchDryers() {
        FirebaseManager.shared.firestore
            .collection("dryer")
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
    
    func fetchWashers() {
        FirebaseManager.shared.firestore
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
                
                print("Fetched \(self.dryers.count) washers.")
            }
    }
    
    func addDryersListener() {
        self.dryerListener?.remove()
        self.dryerListener = FirebaseManager.shared.firestore
            .collection("dryer")
            .order(by: "number")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print(error)
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .modified {
                        if let updatedDryer = try? change.document.data(as: Dryer.self) {
                            self.updateItem(in: &self.dryers, with: updatedDryer) { $0.number == $1.number }
                        }
                    }
                })
            }
    }
    
    func addWashersListener() {
        self.washerListener?.remove()
        self.washerListener = FirebaseManager.shared.firestore
            .collection("washer")
            .order(by: "number")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print(error)
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .modified {
                        if let updatedWasher = try? change.document.data(as: Washer.self) {
                            self.updateItem(in: &self.washers, with: updatedWasher) { $0.number == $1.number }
                        }
                    }
                })
            }
    }
    
    func updateDryerEndedAt(dryer: Dryer, newEndedAt: Date) {
        guard let documentId = dryer.id else {
            print("Dryer document ID is missing.")
            return
        }
        
        // Firestore 참조 가져오기
        let dryerRef = FirebaseManager.shared.firestore
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
    
    func updateItem<T: Identifiable & Equatable>(in array: inout [T], with newItem: T, match: (T, T) -> Bool) {
        if let index = array.firstIndex(where: { match($0, newItem) }) {
            array[index] = newItem
        } else {
            array.append(newItem)
        }
    }
}
