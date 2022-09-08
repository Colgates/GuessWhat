//
//  Response.swift
//  GuessWhat
//
//  Created by Evgenii Kolgin on 07.09.2022.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let word: String
    let meanings: [Meaning]
}

// MARK: - Meaning
struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
    let synonyms, antonyms: [String]
}

// MARK: - Definition
struct Definition: Codable {
    let definition: String
    let example: String?
}
