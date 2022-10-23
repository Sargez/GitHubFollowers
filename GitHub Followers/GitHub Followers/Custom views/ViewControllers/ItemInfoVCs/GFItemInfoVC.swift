//
//  GFItemInfoVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 23.10.2022.
//

import UIKit

class GFItemInfoVC: UIViewController {

    var stackView    = UIStackView()
    var itemInfoOne  = GFItemInfoView()
    var itemInfoTwo  = GFItemInfoView()
    var actionButton = GFButton()
    
    var user: User!
    weak var delegate: UserInfoVCDelegate!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        layoutUI()
        setupStackView()
        setupActionButton()
    }
    
    private func setupViewController() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    private func setupStackView() {
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoOne)
        stackView.addArrangedSubview(itemInfoTwo)
    }
    
    func setupActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() { }
    
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat                                = 20
        let safeAreaGuide                                   = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            actionButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
