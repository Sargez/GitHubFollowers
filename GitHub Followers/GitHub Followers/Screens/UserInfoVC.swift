//
//  UserInfoVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 23.10.2022.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String!
    
    private var headerView          = UIView()
    private var itemViewOne         = UIView()
    private var itemViewTwo         = UIView()
    private var itemViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        layoutUI()
        getUserData()
    }
    
    private func setupViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func getUserData() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: userInfo), to: self.headerView)
                    self.add(childVC: GFRepoItemVC(user: userInfo), to: self.itemViewOne)
                    self.add(childVC: GFFollowersItemVC(user: userInfo), to: self.itemViewTwo)
                }
            case .failure(let error):
                self.presentModallyGFAlertVCOnTheMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func layoutUI() {
        
        let padding: CGFloat = 20
        let height: CGFloat  = 140
        let safeAreaGuide    = view.safeAreaLayoutGuide
        
        itemViews = [headerView, itemViewOne, itemViewTwo]
        
        itemViews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: padding),
                $0.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
        
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: height),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: height)
            
        ])
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func doneButtonTapped() {
        presentingViewController?.dismiss(animated: true)
    }
    
}
