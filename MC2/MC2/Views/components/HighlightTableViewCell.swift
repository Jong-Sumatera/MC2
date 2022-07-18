//
//  HighlightTableViewCell.swift
//  MC2
//
//  Created by Widya Limarto on 04/07/22.
//

import UIKit

class HighlightTableViewCell: UITableViewCell {

    @IBOutlet weak var hLColorView: UIView!
    @IBOutlet weak var hlArrow: UIImageView!
    @IBOutlet weak var hLText: UILabel!
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var hLDetailView: UIStackView!
    @IBOutlet weak var hLStackView: UIStackView!
    
//    @IBOutlet weak var translationText: UILabel!
//    @IBOutlet weak var segmentedControl: UISegmentedControl!
//    @IBOutlet weak var segmentView: UIView!
//    @IBOutlet weak var translationView: TranslationView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.hLColorView.layer.cornerRadius = 8
        outerView.applyShadow(cornerRadius:8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func valueChanged(_ sender: Any) {
        print("value changed")
//        self.segmentView.addSubview(TranslationView())
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        let margins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        contentView.frame.inset = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30))
        
    }
}
