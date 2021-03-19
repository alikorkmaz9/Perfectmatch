//
//  DetailsVC.swift
//  Perfectmatch
//
//  Created by Ali Korkmaz on 11.03.2021.
//

import UIKit
import Alamofire

struct Question: Decodable {
    let id: String!
    let question: String!
    let optionOne: String!
    let optionTwo: String!
    let createdAt: Date!
    let updatedAt: Date!
}

class DetailsVC: UIViewController {
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var questionTF: UITextField!
    @IBOutlet weak var optionOneTF: UITextField!
    @IBOutlet weak var optionTwoTF: UITextField!
    @IBOutlet weak var myButton: UIButton!
    var questions = [Question]()
    
    let kirk = QuestionVC()
    
    func postData () {
            let parameters: [String: AnyObject] = ["question" : questionTF.text as AnyObject,
                                                   "optionOne" : optionOneTF.text as AnyObject,
                                                   "optionTwo" : optionTwoTF.text as AnyObject,
                              ]
            let baseUrl = "https://perfectmatch-app.herokuapp.com/api/v1/questions"
            let headers: HTTPHeaders = [
                .authorization(username: "admin_perfectmatch", password: "^WVxG2@M7J3O"),
                .accept("application/json")]
            AF.request(baseUrl, method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: headers).responseData { (response) in
                debugPrint("Response: \(response)")
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    let data = ("Data: \(utf8Text)")
                    print(data)
                }
                switch response.result {
                case .success(_):
                    do {
                        let obj = try JSONDecoder().decode(Question.self, from: response.data!)
                        self.questions.append(obj)
                        print(self.questions)
                            self.questions.sort {
                                $0.createdAt > $1.createdAt
                            }

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


    override func viewDidLoad() {
        super.viewDidLoad()
        myButton.setTitle("Save", for: .normal)
        myImage.image = UIImage(named: "maltese")
        myImage.contentMode = .scaleToFill
    }
        
    @IBAction func onButtonPressed(_ sender: UIView) {
        postData()
        self.navigationController?.popViewController(animated: true)
    }
    
}
