//
//  Rewards.swift
//  FetchRewardsCodingExercise
//
//  Created by Edward O'Neill on 9/29/20.
//

import Foundation

struct Rewards: Codable {
    let id: Int
    let listId: Int
    let name: String
}

extension Rewards {
    init(_ dictionary: [String: Any]) {
        self.id = dictionary["id"] as? Int ?? -1
        self.listId = dictionary["listId"] as? Int ?? -1
        self.name = dictionary["name"] as? String ?? "no name"
    }
}
