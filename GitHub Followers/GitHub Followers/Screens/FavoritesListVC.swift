//
//  FavoritesListVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 20.09.2022.
//

import UIKit

class FavoritesListVC: UIViewController {

    private var tableView     = UITableView(frame: .zero)
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    private func setupViewController() {
        view.backgroundColor                                   = .systemBackground
        title                                                  = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.frame      = view.bounds
        tableView.rowHeight  = 80
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
    }
    
    private func getFavorites() {
        PersistenceManager.retrieveFavorites {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.favorites = favorites
                
                if favorites.isEmpty {
                    self.showEmptyStateViewOnTheMainThread(with: "No Favorites?\nAdd one on the follower screen")
                } else {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentModallyGFAlertVCOnTheMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                
            }
        }
    }
}


extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier) as! FavoriteCell
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite     = favorites[indexPath.row]
        let destVC       = FollowerListVC()
        destVC.userName  = favorite.login
        destVC.title     = favorite.login
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        
        tableView.performBatchUpdates {
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) {[weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                if self.favorites.isEmpty {
                    self.showEmptyStateViewOnTheMainThread(with: "No Favorites?\nAdd one on the follower screen")
                }
                return
            }
            self.presentModallyGFAlertVCOnTheMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
