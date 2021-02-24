//
//  ViewController.swift
//  Perfectmatch
//
//  Created by Ali Korkmaz on 24.02.2021.
//

import UIKit

class ViewController: UIViewController {
    func textType() {
        let title = UILabel()
        title.sizeToFit()
        title.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        title.textAlignment = .center
        title.font = UIFont(name: "Marker Felt Thin", size: view.frame.width/8)
        title.textColor = .green
        title.text = "PerfectMatch"
        title.numberOfLines = 1
        self.view.addSubview(title)
        title.center = self.view.center
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textType()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if Core.shared.isNewUser() {
            //show onboarding
            let vc = storyboard?.instantiateViewController(identifier: "welcome") as! WelcomeViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }


}

class Core {
    
    static let shared = Core()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func isNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}

