//
//  GFSecondaryLabel.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 23.10.2022.
//

import UIKit

class GFSecondaryLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        setupView()
    }

    private func setupView() {
        textColor                                   = .secondaryLabel
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.90
        lineBreakMode                               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints   = false
    }
}
