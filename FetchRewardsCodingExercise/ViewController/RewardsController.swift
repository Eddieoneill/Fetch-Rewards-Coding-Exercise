//
//  RewardsController.swift
//  FetchRewardsCodingExercise
//
//  Created by Edward O'Neill on 9/29/20.
//

import UIKit

class RewardsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var sortedRewards: [Int: [Rewards]] = [:]
    
    var rewards = [Rewards]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadQuestion()
    }
    
    func loadQuestion() {
        RewardsAPI.getRewards { (result) in
            switch result {
            case .failure(let appError):
                fatalError("couldn't load rewards: \(appError)")
            case .success(let rewards):
                var minVal = Int.max
                var maxVal = Int.min
                for reward in rewards where reward.name != nil && reward.name ?? "" != "" {
                    minVal = min(minVal, reward.listId)
                    maxVal = max(maxVal, reward.listId)
                    self.sortedRewards[reward.listId, default: []].append(reward)
                }
                for id in minVal...maxVal {
                    let reward = self.sortedRewards[id, default: []].sorted(by: { (r1, r2) -> Bool in
                        guard let name1 = r1.name?.split(separator: " "), let name2 = r2.name?.split(separator: " ") else {
                            return true
                        }
                        let num1 = Int(name1[1]) ?? 0
                        let num2 = Int(name2[1]) ?? 0
                        return num1 < num2
                    })
                    self.rewards += reward
                }
            }
        }
    }
}

extension RewardsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rewards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rewardsCell", for: indexPath) as? RewardsCell else { fatalError("couldn't dequeue a RewardsCell") }
        
        var reward = rewards[indexPath.row]
        if let name = reward.name, name.isEmpty {
            reward.name = "no name"
        } else if reward.name == nil {
            reward.name = "no name"
        }
        cell.configureCell(for: reward)
        return cell
    }
}

extension RewardsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
