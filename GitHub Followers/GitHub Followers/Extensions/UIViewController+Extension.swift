//
//  UIViewController+Extension.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 20.09.2022.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView! //REFACTOR THIS

extension UIViewController {
    
    func presentModallyGFAlertVCOnTheMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC                      = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle   = .overFullScreen
            alertVC.modalTransitionStyle     = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariVC(withUrl url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func showLoadingView() {
        containerView                 = UIView(frame: view.bounds)
        containerView.alpha           = 0
        containerView.backgroundColor = .systemBackground
        
        view.addSubview(containerView)
        
        UIViewPropertyAnimator(duration: 0.25, curve: .easeOut) {
            containerView.alpha = 0.8
        }.startAnimation()
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        spinner.startAnimating()
    }
    
    
    func dismissLoadView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    func showEmptyStateViewOnTheMainThread(with message: String) {
        DispatchQueue.main.async {
            let emptyStateView = GFEmptyStateView(messageText: message)
            self.view.addSubview(emptyStateView)
            emptyStateView.frame = self.view.bounds
        }
    }
}
