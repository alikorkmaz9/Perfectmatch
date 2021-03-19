//
//  QuestionVCCell.swift
//  Perfectmatch
//
//  Created by Ali Korkmaz on 9.03.2021.
//

import UIKit

protocol DeleteData {
    func deleteData(_ cel: UITableViewCell)
}

class QuestionVCCell: UITableViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    
    var delegate: DeleteData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Here is the some codes to make the image circular. Also, to fit the texts in the labels.
        questionLabel.insetsLayoutMarginsFromSafeArea = false
        questionLabel?.numberOfLines = 2
        questionLabel.adjustsFontSizeToFitWidth = true

    }
    
    //override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
    //}
    
    @IBAction func onButtonOnePress(_ sender: UIView) {
        delegate?.deleteData(self)
    }
    @IBAction func onButtonTwoPress(_ sender: UIView) {
        delegate?.deleteData(self)
    }
}
