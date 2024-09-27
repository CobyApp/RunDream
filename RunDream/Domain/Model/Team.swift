//
//  Team.swift
//  RunDream
//
//  Created by Coby on 9/27/24.
//

import FirebaseFirestore

struct Team: Codable, Identifiable, Equatable, Hashable {
    @DocumentID var id: String?
    let name: String
    let code: String
    let dryerCount: Int
    let washerCount: Int
}
