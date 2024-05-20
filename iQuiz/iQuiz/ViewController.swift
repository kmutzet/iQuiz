//
//  ViewController.swift
//  iQuiz
//
//  Created by Kate Muret on 5/13/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var settings: UIAlertController!
    @IBOutlet weak var table: UITableView!
    
    var urlErr: UIAlertController!
    
    struct Subject {
        let title: String
        let description: String
        let imageName: String
        let questions: [Question]
    }
    
    var subjects: [Subject] = []
    
    var urlInput: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
        uploadData(newUrl: "https://tednewardsandbox.site44.com/questions.json")
        
        settings = UIAlertController(title: "Settings", message: "Click 'OK' to cancel and click 'Check Now' to download from site", preferredStyle: .alert)
        settings.addTextField { (textField) in textField.text = "enter url"}
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: {  (action) in print("OK")})
        let CheckNowAction = UIAlertAction(title: "Check Now", style: .default, handler: { (action) in self.urlInput = self.settings.textFields![0].text; self.checkDownload()})
        settings.addAction(OKAction)
        settings.addAction(CheckNowAction)
    }
    
    func uploadData(newUrl: String) {
        var newSubjects: [Subject] = []
        let url = URL(string: newUrl)
        if url != nil {
            let session = URLSession.shared.dataTask(with: url!) {
                data, response, error in
                
                if response != nil {
                    if (response! as! HTTPURLResponse).statusCode != 200 {
                        print("Something went wrong! \(String(describing: error))")
                    }
                }
                
                if response != nil {
                    _ = response! as! HTTPURLResponse
                    
                    do {
                        let questions = try JSONSerialization.jsonObject(with: data!)
                        if let subjects = questions as? [[String: Any]] {
                            for subject in subjects {
                                let title = subject["title"] as? String
                                let description = subject["desc"] as? String
                                var imageName = ""
                                if title == "Mathematics" {
                                    imageName = "math"
                                } else if title == "Marvel Super Heroes" {
                                    imageName = "marvel"
                                } else if title == "Science!" {
                                    imageName = "science"
                                }
                                var questions: [Question] = []
                                let qs = subject["questions"] as? [[String: Any]]
                                for q in qs! {
                                    let question = q["text"] as! String
                                    let options = q["answers"] as! [String]
                                    let correct = Int(q["answer"] as! String)!
                                    questions.append(Question(question: question, option1: options[0], option2: options[1], option3: options[2], option4: options[3], correct: correct))
                                }
                                newSubjects.append(Subject(title: title!, description: description!, imageName: imageName, questions: questions))
                            }
                        }
                        if !newSubjects.isEmpty {
                            self.subjects = newSubjects
                            DispatchQueue.main.async {
                                self.table.reloadData()
                            }
                        }
                    }
                    catch {
                        print("Something went boom")
                    }
                }
            }
            session.resume()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let subject = subjects[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCell
        cell.title.text = subject.title
        cell.desc.text = subject.description
        cell.icon.image = UIImage(named: subject.imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let questionVC = storyboard?.instantiateViewController(withIdentifier: "questionVC") as? QuestionViewController {
            questionVC.modalPresentationStyle = .fullScreen
            questionVC.questions = subjects[indexPath.row].questions
            self.present(questionVC, animated: true)
        }
    }
    
    @IBAction func settingsClick(_ sender: Any) {
        self.present(settings, animated: true)
    }
    
    func checkDownload() {
        uploadData(newUrl: urlInput)
    }
}
