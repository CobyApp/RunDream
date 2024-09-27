//
//  Dryer.swift
//  RunDream
//
//  Created by Coby on 9/24/24.
//

import FirebaseFirestore

struct Dryer: Codable, Identifiable, Equatable, Hashable {
    @DocumentID var id: String?
    let number: Int
    var endedAt: Date
}
