//
//  FollowerCells.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 21.09.2022.
//

import UIKit

class FollowerCells: UICollectionViewCell {
    
    static let reuseIdentifier  = "FollowerCells"
    let userNameLabel           = GFTitleLabel(textAlignment: .center, fontSize: 16)
    let avatarImageView         = GFAvatarImageView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        userNameLabel.text = follower.login
    }
    
    private func setupView() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)
        
        let padding:CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            contentView.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            contentView.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: padding),
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
