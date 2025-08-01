//
//  RMEntity.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 30.07.2025.
//

import Foundation

// MARK: - RickAndMorty
struct RickAndMorty: Codable {
    let info: Info?
    let results: [RMCharacter]?
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next: String? //TODO: pagination eklenmeli.
    let prev: String?
}

// MARK: - Result
struct RMCharacter: Codable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: Species?
    let type: String?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
