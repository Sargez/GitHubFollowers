//
//  NetworkManager.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 21.09.2022.
//

import UIKit

class NetworkManager {
    
    static let shared   = NetworkManager()
    static let cache    = NSCache<NSString, UIImage>()
    static let perPage  = 100
    
    private let baseUrl = "https://api.github.com/users/"
        
    
    private init() {}
    
    
    func getFollowers(for userName: String, page: Int, complitionHandler: @escaping (Result<[Follower], GFError>) -> Void) {
        let endPoint = baseUrl + "\(userName)/followers?per_page=\(NetworkManager.perPage)&page=\(page)"
        
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
    
    
    func downloadImage(from urlString: String, complitionHandler: @escaping (UIImage) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = NetworkManager.cache.object(forKey: cacheKey) {
            complitionHandler(image)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
                
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            NetworkManager.cache.setObject(image, forKey: cacheKey)
            
            complitionHandler(image)
        }
    
        task.resume()
    }
    
    
    func getUserInfo(for userName: String, complitionHandler: @escaping (Result<User, GFError>) -> Void) {
        let endPoint = baseUrl + "\(userName)"
        
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
                let user = try decoder.decode(User.self, from: data)
                complitionHandler(.success(user))
            } catch {
                complitionHandler(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
