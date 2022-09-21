//
//  GFEmptyStateView.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 21.09.2022.
//

import UIKit

class GFEmptyStateView: UIView {

    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageViews   = UIImageView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(messageText: String) {
        super.init(frame: .zero)
        messageLabel.text = messageText
        setupView()
    }
    
    
    private func setupView() {
        addSubview(messageLabel)
        addSubview(logoImageViews)
        
        backgroundColor                                          = .systemBackground
        messageLabel.numberOfLines                               = 0
        messageLabel.textColor                                   = .secondaryLabel
        logoImageViews.image                                     = UIImage(named: "empty-state-logo")
        logoImageViews.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 40),
            
            logoImageViews.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageViews.heightAnchor.constraint(equalTo: logoImageViews.widthAnchor),
            logoImageViews.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            logoImageViews.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 120)
        ])
        
    }
}
