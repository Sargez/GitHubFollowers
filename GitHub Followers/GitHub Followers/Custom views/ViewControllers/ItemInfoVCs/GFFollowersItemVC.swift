//
//  GFFollowersItemVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 24.10.2022.
//

import UIKit

final class GFFollowersItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
    }
    
    private func setupItems() {
        itemInfoOne.set(withType: .follower, withCount: user.followers)
        itemInfoTwo.set(withType: .following, withCount: user.following)
        actionButton.set(backGroundColor: .systemGreen, title: "GitHub Profile")
    }
}
