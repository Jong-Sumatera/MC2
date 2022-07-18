//
//  TranslationView.swift
//  MC2
//
//  Created by Widya Limarto on 18/07/22.
//

import UIKit

@IBDesignable
final class TranslationView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    func configureView() {
        guard let view = self.loadViewFromNib(nibName: "TranslationView") else {return}
        self.addSubview(view)
    }

}
