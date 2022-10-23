//
//  GFUserInfoHeaderVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 23.10.2022.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {

    var user: User!
    
    var avatarImageView     = GFAvatarImageView(frame: .zero)
    var usernameLabel          = GFTitleLabel(textAlignment: .left, fontSize: 34)
    var nameLabel           = GFSecondaryLabel(fontSize: 18)
    var locationImageView   = UIImageView()
    var locationLabel       = GFSecondaryLabel(fontSize: 18)
    var bodyLabel           = GFBodyLabel(textAlignment: .left)
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layotUI()
        setupUIElements()
    }
    
    private func setupUIElements() {
        avatarImageView.downloadImage(with: user.avatarUrl)
        usernameLabel.text         = user.login
        nameLabel.text          = user.name ?? ""
        locationLabel.text      = user.location ?? "No location"
        bodyLabel.text          = user.bio ?? "NA"
        bodyLabel.numberOfLines = 3
        
        locationImageView.image = UIImage(named: SFSymbols.location)
    }
    
    private func addSubviews() {
        let allViews = [avatarImageView, usernameLabel, nameLabel, locationLabel, locationImageView, bodyLabel]
        allViews.forEach { view.addSubview($0) }
    }
    
    private func layotUI() {
        
        let padding: CGFloat    = 20
        let textPadding:CGFloat = 12
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textPadding),
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textPadding),
            nameLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textPadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalTo: locationImageView.widthAnchor),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: textPadding),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bodyLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bodyLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textPadding),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bodyLabel.heightAnchor.constraint(equalToConstant: 60)
            
        ])
        
    }
    
}
