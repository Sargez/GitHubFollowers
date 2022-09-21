//
//  FollowerListVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 20.09.2022.
//

import UIKit

class FollowerListVC: UIViewController {

    private enum Section {
        case main
    }
    
    var userName:String!
    private var followers: [Follower] = []
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupCollectionView()
        getFollowers()
        setupDataSource()
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
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCells.self, forCellWithReuseIdentifier: FollowerCells.reuseIdentifier)
    }
    
    
    private func createThreeColumnCollectionViewLayout() -> UICollectionViewFlowLayout {
        let width                    = view.bounds.width
        let padding: CGFloat         = 12
        let middleSpacing: CGFloat   = 10
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
                self.followers = followers
                self.updateData()
            case . failure(let error):
                self.presentModallyGFAlertVCOnTheMainThread(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView,
                                                                             cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCells.reuseIdentifier, for: indexPath) as! FollowerCells
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
