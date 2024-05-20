//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Kate Muret on 5/17/24.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var option1: UILabel!
    @IBOutlet weak var option2: UILabel!
    @IBOutlet weak var option3: UILabel!
    @IBOutlet weak var option4: UILabel!
    
    var questions: [Question] = []
    var questionID = 0
    var selected = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !questions.isEmpty {
            question.text = questions[questionID].question
            option1.text = questions[questionID].option1
            option2.text = questions[questionID].option2
            option3.text = questions[questionID].option3
            option4.text = questions[questionID].option4
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonClick() {
        if let subjectVC = storyboard?.instantiateViewController(withIdentifier: "subjectVC") as? ViewController {
            subjectVC.modalPresentationStyle = .fullScreen
            self.present(subjectVC, animated: true)
        }
    }
    
    @IBAction func option1Click() {
        selected = 1
        option1.textColor = .systemPurple
        option2.textColor = .black
        option3.textColor = .black
        option4.textColor = .black
    }
    
    @IBAction func option2Click() {
        selected = 2
        option1.textColor = .black
        option2.textColor = .systemPurple
        option3.textColor = .black
        option4.textColor = .black
    }
    
    @IBAction func option3Click() {
        selected = 3
        option1.textColor = .black
        option2.textColor = .black
        option3.textColor = .systemPurple
        option4.textColor = .black
    }
    
    @IBAction func option4Click() {
        selected = 4
        option1.textColor = .black
        option2.textColor = .black
        option3.textColor = .black
        option4.textColor = .systemPurple
    }
    
    @IBAction func submitButtonClick() {
        if selected != 0 {
            if let answerVC = storyboard?.instantiateViewController(withIdentifier: "answerVC") as? AnswerViewController {
                answerVC.modalPresentationStyle = .fullScreen
                answerVC.questions = questions
                answerVC.questionID = questionID
                answerVC.selected = selected
                answerVC.score = score
                self.present(answerVC, animated: true)
            }
        }
    }
}
