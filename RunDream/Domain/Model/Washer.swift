//
//  Washer.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import FirebaseFirestore

struct Washer: Codable, Identifiable, Equatable {
    @DocumentID var id: String?
    let number: Int
    var endedAt: Date
}
