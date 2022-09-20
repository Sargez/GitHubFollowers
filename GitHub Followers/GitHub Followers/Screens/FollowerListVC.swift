//
//  FollowerListVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 20.09.2022.
//

import UIKit

class FollowerListVC: UIViewController {

    var userName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { followers, errorMessage in
            guard let followers = followers else {
                self.presentModallyGFAlertVCOnTheMainThread(title: "Test", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            
            print("Count: \(followers.count)")
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
