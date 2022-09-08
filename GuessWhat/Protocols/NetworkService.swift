//
//  NetworkService.swift
//  GuessWhat
//
//  Created by Evgenii Kolgin on 08.09.2022.
//

import Foundation

protocol NetworkService {
    func fetchHint(for answer: String, completion: @escaping (Result<[Response], NetworkError>) -> Void)
}
