//
//  ErrorMessage.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 21.09.2022.
//

import Foundation

enum GFError: String, Error {
    case invalidRequest   = "This username created an invalid request. Please try again."
    case badConnection    = "Unable to complete your request. Please check your internet connection and try again."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
}

