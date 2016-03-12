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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        currPhrase = phrase
        incorrects.text = " "
        var lettersString = ""
        for char in phrase.characters {
            if char == " " {
                lettersString += "  "
            } else {
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
    @IBAction func incorrectAction(sender: AnyObject) {
        if textGuess.text?.characters.count == 1 && pictureIndex < 7 {
            incorrects.text = incorrects.text! + " " + textGuess.text!
            picture.image = UIImage(named: pictures[pictureIndex++])
        }
    }

    @IBAction func correctAction(sender: AnyObject) {
        if textGuess.text?.characters.count == 1 && index < currPhrase?.characters.count {
            let replaceChar = currPhrase![currPhrase!.startIndex.advancedBy(index)]
            let myRange = letters.text!.startIndex.advancedBy(index)..<letters.text!.startIndex.advancedBy(index + 2)
            letters.text = letters.text!.stringByReplacingCharactersInRange(myRange, withString: String(replaceChar))
            index++;
            if replaceChar == " " {
                correctAction(sender)
            }
        }
    }
}
