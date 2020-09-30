//
//  RewardsCell.swift
//  FetchRewardsCodingExercise
//
//  Created by Edward O'Neill on 9/30/20.
//

import UIKit

class RewardsCell: UITableViewCell {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var listId: UILabel!
    @IBOutlet weak var name: UILabel!
    
    func configureCell(for reward: Rewards) {
        id.text = "\(reward.id)"
        listId.text = "\(reward.listId)"
        name.text = reward.name ?? "no name"
    }
    
}
