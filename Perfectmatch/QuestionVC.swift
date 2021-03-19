//
//  QuestionVC.swift
//  Perfectmatch
//
//  Created by Ali Korkmaz on 9.03.2021.
//

import UIKit
import Alamofire

struct Questions: Decodable {
    let id: String!
    let question: String!
    let optionOne: String!
    let optionTwo: String!
    let createdAt: Date!
    let updatedAt: Date!
}

class QuestionVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DeleteData {
    var question: String?
    var optionOne: String?
    var optionTwo: String?
    var questions = [Questions]()
    @IBOutlet weak var questionTable: UITableView!
    
    
    func deleteData(_ cel: UITableViewCell) {
        if let indexPath = questionTable.indexPath(for: cel) {
            let a = questions[indexPath.row].id!
            let baseUrl = "https://perfectmatch-app.herokuapp.com/api/v1/questions/\(a)"
            let headers: HTTPHeaders = [
                .authorization(username: "admin_perfectmatch", password: "^WVxG2@M7J3O"),
                .accept("application/json")]
            AF.request(baseUrl, method: .delete, headers: headers).responseJSON { response in
            }
            questions.remove(at: indexPath.row)
            questionTable.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func getData (endpoint: String) {
        questions.removeAll(keepingCapacity: false)
        let baseUrl = "https://perfectmatch-app.herokuapp.com/api/v1/"
        let endPointUrl = "\(baseUrl)\(endpoint)"
        let headers: HTTPHeaders = [
            .authorization(username: "admin_perfectmatch", password: "^WVxG2@M7J3O"),
            .accept("application/json")
        ]
        
        AF.request(endPointUrl, headers: headers)
            .responseJSON { response in
                // check for errors
                switch response.result {
                case .success(_):
                    do {
                        let obj = try JSONDecoder().decode([Questions].self, from: response.data!)
                        for q in obj {
                            self.questions.append(q)
                        }
                        self.questions.sort {
                            $0.createdAt > $1.createdAt
                        }
                        self.questionTable.reloadData()
                        
                    } catch let jsonErr {
                        print("Failed to decode json:", jsonErr)
                    }
                    
                    break
                case .failure(_):
                    print("Response failed")
                    break
                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuestionVCCell
        let question = questions[indexPath.row]
        cell.questionLabel.text = question.question
        cell.buttonOne.setTitle(question.optionOne, for: .normal)
        cell.buttonTwo.setTitle(question.optionTwo, for: .normal)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.questions.remove(at: indexPath.row)
            self.questionTable.deleteRows(at: [indexPath], with: .left)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTable.delegate = self
        questionTable.dataSource = self
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        getData(endpoint: "questions")
    }
    
    @objc func addButtonClicked() {
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
}
