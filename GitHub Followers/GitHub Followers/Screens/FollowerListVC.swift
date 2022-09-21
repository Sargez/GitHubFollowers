//
//  FollowerListVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 20.09.2022.
//

import UIKit

class FollowerListVC: UIViewController {

    var userName:String!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupCollectionView()
        getFollowers()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    private func setupViewController() {
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnCollectionViewLayout())
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCells.self, forCellWithReuseIdentifier: FollowerCells.reuseIdentifier)
    }
    
    
    private func createThreeColumnCollectionViewLayout() -> UICollectionViewFlowLayout {
        let width                    = view.bounds.width
        let padding: CGFloat         = 10
        let middleSpacing: CGFloat   = 12
        let availableWidth           = width - (2 * padding) - (2 * middleSpacing)
        let itemWidth                = availableWidth / 3
        
        let flowLayout           = UICollectionViewFlowLayout()
        flowLayout.sectionInset  = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize      = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    
    private func getFollowers() {
        NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
           
            switch result {
            case .success(let followers):
                print(followers)
            case . failure(let error):
                self.presentModallyGFAlertVCOnTheMainThread(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
