//
//  LaunchViewModel.swift
//  RunDream
//
//  Created by Coby on 9/27/24.
//

import SwiftUI

import Firebase
import FirebaseFirestore

class LaunchViewModel: ObservableObject {
    
    @Published var teams: [Team] = []
    
    init() {
        self.fetchTeams()
    }
    
    func fetchTeams() {
        FirebaseManager.shared.firestore
            .collection("team")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching teams: \(error.localizedDescription)")
                    return
                }
                
                self.teams = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Team.self)
                } ?? []
                
                print("Fetched \(self.teams.count) teams.")
            }
    }
}
