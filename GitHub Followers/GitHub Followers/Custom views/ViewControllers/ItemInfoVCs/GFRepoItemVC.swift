//
//  GFRepoItemVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 24.10.2022.
//

import UIKit

final class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
    }
    
    private func setupItems() {
        itemInfoOne.set(withType: .repo, withCount: user.publicRepos)
        itemInfoTwo.set(withType: .gists, withCount: user.publicGists)
        actionButton.set(backGroundColor: .systemPurple, title: "Get Followers")
    }
}
