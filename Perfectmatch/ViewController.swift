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


}

