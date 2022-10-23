//
//  UserInfoVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 23.10.2022.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String!
    
    private var headerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
        
        layoutUI()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: userInfo), to: self.headerView)
                }
            case .failure(let error):
                self.presentModallyGFAlertVCOnTheMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
    }
    
    private func layoutUI() {
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = headerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func doneButtonTapped() {
        presentingViewController?.dismiss(animated: true)
    }
    
}
