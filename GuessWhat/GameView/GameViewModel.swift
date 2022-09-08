//
//  GameViewModel.swift
//  GuessWhat
//
//  Created by Evgenii Kolgin on 08.09.2022.
//

import UIKit

class GameViewModel {
    private var difficulty = Constants.difficulty
    var guesses: [[Character?]] = [[]]
    private var answer: String = ""
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        pickAWord()
        configureBoard()
    }
    
    func pickAWord() {
        switch Constants.difficulty {
        case .easy:
            answer = Words.easy.randomElement() ?? "home"
        case .medium:
            answer = Words.medium.randomElement() ?? "comma"
        case .hard:
            answer = Words.hard.randomElement() ?? "trance"
        }
    }
    
    func configureBoard() {
        guesses = Array(repeating: Array(repeating: nil, count: difficulty.value.letters), count: difficulty.value.attempts)
    }
    
    func buttonTapped(letter: Character, completion: @escaping (Bool) -> Void) {
        var stop = false
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    
                    if letter == "<" {
                        guard j != 0 else { break }
                        guesses[i][j-1] = nil
                    } else {
                        guesses[i][j] = letter
                        
                        if Array(answer) == guesses[i].compactMap({$0}) {
                            completion(true)
                        }
                        
                        if guesses[difficulty.value.attempts - 1].compactMap({$0}).count == difficulty.value.letters {
                            completion(false)
                        }
                    }
                    stop = true
                    break
                }
            }
            if stop {
                break
            }
        }
    }
    
    func colorForCell(with indexPath: IndexPath) -> UIColor? {
        let rowIndex = indexPath.section
        let count = guesses[rowIndex].compactMap({ $0 }).count
        guard count == difficulty.value.letters else { return nil}
        let indexedAnswer = Array(answer)
        guard let letter = guesses[indexPath.section][indexPath.row], indexedAnswer.contains(letter) else { return nil }
        
        if indexedAnswer[indexPath.row] == letter {
            return .systemGreen
        }
        return .systemOrange
    }
    
    func fetchHint(completion: @escaping (String) -> Void) {
        networkService.fetchHint(for: answer) { result in
            switch result {
            case .success(let response):
                guard let definition = response[0].meanings[0].definitions.randomElement()?.definition else { return }
                completion(definition)
            case .failure(let error):
                completion("There's something wrong with the connection: \(error.localizedDescription)")
            }
        }
    }
}
