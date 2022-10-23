//
//  GFButton.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 21.09.2022.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(backGroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backGroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    
    private func configure() {
        layer.cornerRadius      = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backGroundColor: UIColor, title: String) {
        self.backgroundColor = backGroundColor
        self.setTitle(title, for: .normal)
    }
}
