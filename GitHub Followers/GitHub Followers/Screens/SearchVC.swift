//
//  SearchVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 20.09.2022.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView        = UIImageView()
    let userNameTextField    = GFTextField()
    let callToActionButton   = GFButton(backGroundColor: .systemGreen, title: "Get followers")
    
    var userNameTextIsEntered: Bool {
        return !userNameTextField.text!.removeWhitespaces().isEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLogoImageView()
        setupUserNameTextField()
        setupCallToActionButton()
        createTapGestureToDismissKeyboard()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
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
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            view.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor, constant: 50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func setupCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: callToActionButton.bottomAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func createTapGestureToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func pushFollowerListVC() {
        guard userNameTextIsEntered else {
            presentModallyGFAlertVCOnTheMainThread(title: "Empty user name", message: "You should type any user name. We want to know who to look for 😀.", buttonTitle: "Ok")
            return
        }
        
        let followerListVC      = FollowerListVC()
        followerListVC.userName = userNameTextField.text!
        followerListVC.title    = userNameTextField.text!
        navigationController?.pushViewController(followerListVC, animated: true)
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
