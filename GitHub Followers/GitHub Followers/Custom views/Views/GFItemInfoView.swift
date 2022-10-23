//
//  GFItemInfoView.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 23.10.2022.
//

import UIKit

enum TypeItemInfo {
    case repo, gists, follower, following
}

class GFItemInfoView: UIView {

    private var symbolImageView = UIImageView()
    private var infoLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private var countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(withType type: TypeItemInfo, withCount count: Int) {
        switch type {
        case .repo:
            symbolImageView.image   = UIImage(named: SFSymbols.repo)
            infoLabel.text          = "Public Repos"
        case .gists:
            symbolImageView.image   = UIImage(named: SFSymbols.gists)
            infoLabel.text          = "Public Gists"
        case .follower:
            symbolImageView.image   = UIImage(named: SFSymbols.followers)
            infoLabel.text          = "Followers"
        case .following:
            symbolImageView.image   = UIImage(named: SFSymbols.following)
            infoLabel.text          = "Following"
        }
        
        countLabel.text             = String(count)
    }
    
    private func setupView() {
        addSubview(symbolImageView)
        addSubview(infoLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.tintColor = .systemBackground
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalTo: symbolImageView.widthAnchor),
            
            infoLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 10),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 10),
            countLabel.leadingAnchor.constraint(equalTo: symbolImageView.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
