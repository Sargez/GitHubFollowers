//
//  NetworkManager.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 21.09.2022.
//

import Foundation

class NetworkManager {
    static let shared   = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    private let perPage = 100
    
    
    private init() {}
    
    
    func getFollowers(for userName: String, page: Int, complitionHandler: @escaping (Result<[Follower], GFError>) -> Void) {
        let endPoint = baseUrl + "\(userName)/followers?per_page=\(perPage)&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            complitionHandler(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                complitionHandler(.failure(.badConnection))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                complitionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                complitionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                complitionHandler(.success(followers))
            } catch {
                complitionHandler(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
