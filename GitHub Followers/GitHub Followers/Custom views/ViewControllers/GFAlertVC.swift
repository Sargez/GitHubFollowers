//
//  GFAlertVC.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 20.09.2022.
//

import UIKit

class GFAlertVC: UIViewController {

    private var containerView: GFContainerAlertView!
    private weak var delegate: GFContainerAlertViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        setupContainerView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(title:String, message:String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.containerView = GFContainerAlertView(textTitle: title, message: message, buttonTitle: buttonTitle)
    }
    
    
    private func setupContainerView() {
        view.addSubview(containerView)
        containerView.delegate = self
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])        
    }
    
    
    private func dismissVC() {
        presentingViewController?.dismiss(animated: true)
    }
}


extension GFAlertVC: GFContainerAlertViewDelegate {
    func actionButtonTapped() {
        dismissVC()
    }
}
