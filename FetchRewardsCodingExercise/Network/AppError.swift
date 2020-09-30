//
//  AppError.swift
//  FetchRewardsCodingExercise
//
//  Created by Edward O'Neill on 9/29/20.
//

import Foundation

enum AppError: Error {
  case badURL(String)
  case noResponse
  case networkClientError(Error)
  case noData
  case decodingError(Error)
  case badStatusCode(Int)
  case badMimeType(String)
}
