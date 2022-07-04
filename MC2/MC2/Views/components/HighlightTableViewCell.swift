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
    @IBOutlet weak var hLDetailStackView: UIStackView!
    @IBOutlet weak var hLStackView: UIStackView!
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
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        let margins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        contentView.frame.inset = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30))
        
    }
}
