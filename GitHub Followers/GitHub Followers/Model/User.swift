//
//  User.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 20.09.2022.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var followers: Int
    var following: Int
    var createdAt: String
}
