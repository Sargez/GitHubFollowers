//
//  GFContainerAlertView.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 20.09.2022.
//

import UIKit

protocol GFContainerAlertViewDelegate: AnyObject {
    func actionButtonTapped()
}

class GFContainerAlertView: UIView {

    private let titleLabel   = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel = GFBodyLabel(textAlignment: .center)
    private let actionButton = GFButton(backGroundColor: .systemPink, title: "Ok")
    
    private let padding: CGFloat = 20
    
    private var textTitle: String!
    private var message: String!
    private var buttonTitle: String!
    
    weak var delegate: GFContainerAlertViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(textTitle:String, message:String, buttonTitle: String) {
        super.init(frame: .zero)
        self.textTitle       = textTitle
        self.message         = message
        self.buttonTitle     = buttonTitle
        setupView()
    }
    
    
    private func setupView() {
        layer.cornerRadius                        = 16
        layer.borderWidth                         = 2
        layer.borderColor                         = UIColor.white.cgColor
        backgroundColor                           = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        setupTitleLabel()
        setupActionButton()
        setupMessageLabel()
    }
    
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = textTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    private func setupActionButton() {
        addSubview(actionButton)
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            bottomAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: actionButton.trailingAnchor, constant: padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func actionButtonTapped() {
        delegate?.actionButtonTapped()
    }
    
    private func setupMessageLabel() {
        addSubview(messageLabel)
        messageLabel.text = message ?? "Unvailable to get a response"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: padding),
            actionButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 12)
        ])
    }
}
