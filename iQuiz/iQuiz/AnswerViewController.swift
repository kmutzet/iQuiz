//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Kate Muret on 5/19/24.
//

import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var result: UILabel!
    
    var questions: [Question] = []
    var questionID = 0
    var selected = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        question.text = questions[questionID].question
        let correct: String!
        if questions[questionID].correct == 1 {
            correct = questions[questionID].option1
        } else if questions[questionID].correct == 2 {
            correct = questions[questionID].option2
        } else if questions[questionID].correct == 3 {
            correct = questions[questionID].option3
        } else {
            correct = questions[questionID].option4
        }
        answer.text = "The correct answer is " + correct
        if selected == questions[questionID].correct {
            result.text = "You were right!"
            score = score + 1
        } else {
            result.text = "You were wrong :("
        }
        
    }
    
    @IBAction func backButtonClick() {
        if let subjectVC = storyboard?.instantiateViewController(withIdentifier: "subjectVC") as? ViewController {
            subjectVC.modalPresentationStyle = .fullScreen
            self.present(subjectVC, animated: true)
        }
    }
    
    @IBAction func nextButtonClick() {
        if (questionID + 1) >= questions.count {
            if let finishedVC = storyboard?.instantiateViewController(withIdentifier: "finishedVC") as? FinishedViewController {
                finishedVC.modalPresentationStyle = .fullScreen
                finishedVC.max = questions.count
                finishedVC.score = score
                self.present(finishedVC, animated: true)
            }
        } else if let questionVC = storyboard?.instantiateViewController(withIdentifier: "questionVC") as? QuestionViewController {
            questionVC.modalPresentationStyle = .fullScreen
            questionVC.questions = questions
            questionVC.questionID = questionID + 1
            questionVC.selected = 0
            questionVC.score = score
            self.present(questionVC, animated: true)
        }
    }
}
