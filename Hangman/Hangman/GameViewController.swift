//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {


    @IBOutlet weak var incorrects: UILabel!
    @IBOutlet weak var textGuess: UITextField!
    @IBOutlet weak var letters: UILabel!
    @IBOutlet weak var picture: UIImageView!
    var index = 0
    var pictureIndex = 1
    var currPhrase: String?
    let pictures: [String] = ["hangman1.gif", "hangman2.gif", "hangman3.gif", "hangman4.gif", "hangman5.gif", "hangman6.gif", "hangman7.gif"]
    var lettersSet: Set<String> = []
    var incorrectSet: Set<String> = []
    var correctSet: Set<String> = []
    let loseAlert = UIAlertController(
        title: "You Lose!",
        message: "Better luck next time.",
        preferredStyle: .Alert)
    let winAlert = UIAlertController(
        title: "You Win!",
        message: "You know your Beatles! You are a gentleman and a scholar.",
        preferredStyle: .Alert)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        textGuess.becomeFirstResponder()

        // Do any additional setup after loading the view.
        newGame()
        loseAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        winAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
    }
    
    func newGame() {
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        picture.image = UIImage(named: pictures[0])
        print(phrase)
        index = 0
        pictureIndex = 1
        currPhrase = phrase
        incorrects.text = " "
        var lettersString = ""
        lettersSet = Set<String>()
        incorrectSet = Set<String>()
        correctSet = Set<String>()
        for char in phrase.characters {
            if char == " " {
                lettersString += "  "
            } else {
                lettersSet.insert(String(char))
                lettersString += " _"
            }
        }
        letters.text = lettersString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func guess(sender: AnyObject) {
        if (textGuess.text?.characters.count)! == 1 && index < (lettersSet.count) && pictureIndex < 7 && NSCharacterSet.letterCharacterSet().characterIsMember((textGuess.text?.utf16[(textGuess.text?.utf16.startIndex)!])!) {
            if lettersSet.contains(textGuess.text!.uppercaseString) {
                correctAction()
            } else {
                incorrectAction()
            }
        }
        textGuess.text = nil
    }
    
    func incorrectAction() {
        if !incorrectSet.contains(textGuess.text!.uppercaseString) {
            incorrectSet.insert(textGuess.text!.uppercaseString)
            incorrects.text = incorrects.text! + " " + textGuess.text!.uppercaseString
            picture.image = UIImage(named: pictures[pictureIndex++])
            if pictureIndex == 7 {
                self.presentViewController(loseAlert, animated: true, completion: nil)
            }
        }
    }

    func correctAction() {
        if !correctSet.contains(textGuess.text!.uppercaseString) {
            correctSet.insert(textGuess.text!.uppercaseString)
            var lettersString = ""
            for char in currPhrase!.characters {
                if char == " " {
                    lettersString += "  "
                } else if correctSet.contains(String(char)) {
                    lettersString += String(char)
                } else {
                    lettersString += " _"
                }
            }
            letters.text = lettersString
            index++
            if index == lettersSet.count {
                self.presentViewController(winAlert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func newGame(sender: AnyObject) {
        newGame()
    }
}
