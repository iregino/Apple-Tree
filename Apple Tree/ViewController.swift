//
//  ViewController.swift
//  Apple Tree
//
//  Created by student14 on 2/19/19.
//  Copyright © 2019 student14. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Variables
    var listOfWords = ["sugar", "pie", "cinnamon", "vanilla", "crust", "apple", "butter"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        // Start a new round after a win
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        // Start a new round after a loss
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newRound()
    }
    
    func newRound() {
        // Disable buttons when there's no more word to guess
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    // Enable or disable letter buttons
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    // Update the user interface with correct guessed letters, total wins and total losses labels
    func updateUI() {
        // Create an array of characters using map method
        let letterArray = currentGame.formattedWord.map { String($0)}
        // Join all characters separated by a space into a string
        correctWordLabel.text = letterArray.joined(separator: " ")
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    // When button is pressed, the particular button is disabled, convert letter into character
    // and update guessedLetters property of an instance of a Game. Finally calls updateGameState method
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        sender.backgroundColor = UIColor.gray
        let letterString = sender.title(for: .normal)
        let letter = Character(letterString!.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    // Updates the total wins or total losses depending on the correct guessed word;
    // otherwise, app allow users to continue to guess the word
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
            updateUI()
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            updateUI()
        } else {
            updateUI()
        }
    }
    
}



