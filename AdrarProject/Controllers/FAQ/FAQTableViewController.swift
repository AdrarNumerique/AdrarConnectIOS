//
//  FAQTableViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

class FAQTableViewController: UITableViewController {
    var questionsReponses: [QuestionReponse] = []
    var cellId = "mainQuestionReponse"
   
    @IBOutlet weak var faqTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionsReponses = catchFaq()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }
    //récuperation des données et transformation en tableau de questionReponse
    private func catchFaq() -> [QuestionReponse] {
        let faqJsonAfterUD = UserDefaults.standard.string(forKey: "faq")
        
        if let result: Data = faqJsonAfterUD?.data(using: .utf8) {
            do {
                return try JSONDecoder().decode([QuestionReponse].self, from: result)
            } catch {
                print(error.localizedDescription)
            }
        }
        return []
    }
    //Nombre de section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //Nombre de cellule
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsReponses.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let lngQuestionReponse = questionsReponses[indexPath.row].question.count + questionsReponses[indexPath.row].reponse.count
        var heightCell:CGFloat = 60
        for _ in 1...lngQuestionReponse/10 {
           heightCell += 4
        }
        
        return heightCell
    }
    //Envoie de cellule
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let questionReponse = questionsReponses[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,for: indexPath) as! QuestionReponseCell
        cell.setupCell(questionsReponses[indexPath.row])
        cell.questionLbl.text = questionReponse.question
        cell.reponseLbl.text = questionReponse.reponse
        
        return cell
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


