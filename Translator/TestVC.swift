//
//  TestVC.swift
//  Translator
//
//  Created by Dan Lindsay on 2016-10-26.
//  Copyright © 2016 Dan Lindsay. All rights reserved.
//

import UIKit
import GameplayKit

class TestVC: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
   
    @IBOutlet weak var prompt: UILabel!
    
    var words: [String]!
    var questionCounter = 0
    var showingQuestion = true

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(nextTapped))
        words = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: words) as! [String]
        title = "TEST"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        askQuestion()
    }

    func nextTapped() {
        
        //move between showing question and answer
        showingQuestion = !showingQuestion
        
        if showingQuestion {
            
            //we should be showing the question - reset!
            prepareForNextQuestion()
        } else {
            
            //we should be showing the answer - show it now, and set the color to green
            prompt.text = words[questionCounter].components(separatedBy: "::")[0]
            prompt.textColor = UIColor(red: 0, green: 0.7, blue: 0, alpha: 1)
        }
    }
    
    func askQuestion() {
        
        //move the question counter one place
        questionCounter += 1
        
        if questionCounter == words.count {
            
            //wrap it back to 0 if we've gone beyond the size of the array
            questionCounter = 0
        }
        //pull out the french word at the current position
        prompt.text = words[questionCounter].components(separatedBy: "::")[1]
    }
    
    func prepareForNextQuestion() {
        
        ///reset the prompt back to black
        prompt.textColor = UIColor.black
        
        //prceed with thte next question
        askQuestion()
    }
    

   

}
