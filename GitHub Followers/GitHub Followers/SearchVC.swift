//
//  SearchVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 20.09.2022.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView        = UIImageView()
    let usernameTextField    = GFTextField()
    let callToActionButton     = GFButton(backGroundColor: .systemGreen, title: "Get followers")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLogoImageView()
        setupUserNameTextField()
        setupCallToActionButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    private func setupLogoImageView() {
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image                                     = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor)
        ])
    }

    
    private func setupUserNameTextField() {
        view.addSubview(usernameTextField)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            view.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor, constant: 50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func setupCallToActionButton() {
        view.addSubview(callToActionButton)
        
        NSLayoutConstraint.activate([
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: callToActionButton.bottomAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
