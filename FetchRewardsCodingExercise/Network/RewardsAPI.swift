//
//  RewardsAPI.swift
//  FetchRewardsCodingExercise
//
//  Created by Edward O'Neill on 9/29/20.
//

import Foundation

struct RewardsAPI {
    
    static func getRewards(completion: @escaping (Result<[Rewards], AppError>) -> ()) {
        let urlString = "https://fetch-hiring.s3.amazonaws.com/hiring.json"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                do {
                    let question = try JSONDecoder().decode([Rewards].self, from: data)
                    completion(.success(question))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
}
