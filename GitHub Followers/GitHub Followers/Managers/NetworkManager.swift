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
    
    
    func getFollowers(for userName: String, page: Int, complitionHandler: @escaping ([Follower]?, String?)->Void) {
        let endPoint = baseUrl + "\(userName)/followers?per_page=\(perPage)&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            complitionHandler(nil, "Unvailable to get the data. Bad request url. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                complitionHandler(nil, "Unable to get data. Please check youe internet connection and try again.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                complitionHandler(nil, "Invalid response from the server. Please try again.")
                return
            }
            
            guard let data = data else {
                complitionHandler(nil, "The data received from the server was invalid. Please try again.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                complitionHandler(followers, nil)
            } catch {
                complitionHandler(nil, "The data received from the server was invalid. Please try again.")
            }
        }
        
        task.resume()
    }
}
