//
//  UserInfoVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 23.10.2022.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTappedGitHubProfile(for user: User)
    func didTappedGetFollowers(with user: User)
}

class UserInfoVC: UIViewController {

    var username: String!
    weak var delegate: FollowerListVCDelegate!
    
    private var headerView          = UIView()
    private var itemViewOne         = UIView()
    private var itemViewTwo         = UIView()
    private var dateLabel           = GFBodyLabel(textAlignment: .center)
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
                DispatchQueue.main.async { self.setupElementsWithUser(userInfo: userInfo) }
            case .failure(let error):
                self.presentModallyGFAlertVCOnTheMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func setupElementsWithUser(userInfo: User) {
        
        let repoVC      = GFRepoItemVC(user: userInfo)
        repoVC.delegate = self
        
        let followersVC      = GFFollowersItemVC(user: userInfo)
        followersVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: userInfo), to: self.headerView)
        self.add(childVC: repoVC, to: self.itemViewOne)
        self.add(childVC: followersVC, to: self.itemViewTwo)
        
        self.dateLabel.text = "GitHub since \(userInfo.createdAt.convertToDisplayFormat())"
    }
    
    private func layoutUI() {
        
        let padding: CGFloat = 20
        let height: CGFloat  = 140
        let safeAreaGuide    = view.safeAreaLayoutGuide
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
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
            itemViewTwo.heightAnchor.constraint(equalToConstant: height),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
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


extension UserInfoVC: UserInfoVCDelegate {
    
    func didTappedGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentModallyGFAlertVCOnTheMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(withUrl: url)
    }
    
    func didTappedGetFollowers(with user: User) {
        guard user.followers != 0 else {
            presentModallyGFAlertVCOnTheMainThread(title: "No followers", message: "This user has no followers.", buttonTitle: "Ok")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismiss(animated: true)
    }
}
