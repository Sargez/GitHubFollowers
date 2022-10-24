//
//  FavoriteCell.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 24.10.2022.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseIdentifier  = "FavoriteCell"
    let userNameLabel           = GFTitleLabel(textAlignment: .center, fontSize: 24)
    let avatarImageView         = GFAvatarImageView(frame: .zero)
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favorite: Follower) {
        userNameLabel.text = favorite.login
        avatarImageView.downloadImage(with: favorite.avatarUrl)
    }
    
    private func setupCell() {
        addSubview(userNameLabel)
        addSubview(avatarImageView)
        
        let padding: CGFloat = 12
        self.accessoryType   = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
