//
//  FollowerListVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 20.09.2022.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollowers(for userName: String)
}

class FollowerListVC: UIViewController {

    private enum Section { case main }
    
    var userName:String!
    private var followers: [Follower]           = []
    private var filteredFollowers: [Follower]   = []
    private var page                            = 1
    private var hasMoreFollowers                = true
    private var isSearching                     = false
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupSearchController()
        setupCollectionView()
        getFollowers(for: userName, page: page)
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
    

    private func setupSearchController() {
        let searchController                     = UISearchController()
        searchController.searchResultsUpdater    = self
        searchController.searchBar.placeholder   = "Search for a username"
        searchController.searchBar.delegate      = self
        navigationItem.searchController          = searchController
    }
    
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnCollectionViewLayout(in: view))
        view.addSubview(collectionView)
        
        collectionView.delegate        = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCells.self, forCellWithReuseIdentifier: FollowerCells.reuseIdentifier)
    }
        
    
    private func getFollowers(for userName: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadView()
            switch result {
            case .success(let followers):
                if followers.count < NetworkManager.perPage { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    self.showEmptyStateViewOnTheMainThread(with: "This user doesn't have any followers. Go follow them.")
                    return
                }
                self.updateData(on: self.followers)
            case . failure(let error):
                self.presentModallyGFAlertVCOnTheMainThread(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView) { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCells.reuseIdentifier, for: indexPath) as! FollowerCells
            cell.set(follower: follower)
            return cell
        }
    }
    
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}


extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = collectionView.contentOffset.y
        let contentHeight = collectionView.contentSize.height
        let height = collectionView.frame.height
        
        if offsetY > contentHeight - height, hasMoreFollowers {
            page += 1
            getFollowers(for: userName, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activeArray  = isSearching ? filteredFollowers : followers
        let follower     = activeArray[indexPath.item]
        
        let destVC       = UserInfoVC()
        destVC.username  = follower.login
        destVC.delegate  = self
        
        let navVC = UINavigationController(rootViewController: destVC)
        present(navVC, animated: true)

    }
}


extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isSearching = false
            return
        }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
        filteredFollowers.removeAll()
        isSearching = false
    }
}


extension FollowerListVC: FollowerListVCDelegate {
    
    func didRequestFollowers(for userName: String) {
        self.userName = userName
        self.title = userName
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        page = 1
        getFollowers(for: userName, page: page)
    }
}
