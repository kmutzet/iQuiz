//
//  Question.swift
//  iQuiz
//
//  Created by Kate Muret on 5/19/24.
//

import UIKit

class Question {
    
    let question: String!
    let option1: String!
    let option2: String!
    let option3: String!
    let option4: String!
    let correct: Int!
    
    init(question: String, option1: String, option2: String, option3: String, option4: String, correct: Int) {
        self.question = question
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        self.option4 = option4
        self.correct = correct
    }
    
}

