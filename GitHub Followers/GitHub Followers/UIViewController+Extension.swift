//
//  UIViewController+Extension.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 20.09.2022.
//

import UIKit

extension UIViewController {
    
    func presentModallyGFAlertVCOnTheMainThread(title: String, message: String, buttonTitle: String) {
        let alertVC                      = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle   = .overFullScreen
        alertVC.modalTransitionStyle     = .crossDissolve
        present(alertVC, animated: true)
    }
    
}
