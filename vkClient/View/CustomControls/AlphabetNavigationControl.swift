//
//  letterNavigationControl.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 15/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class AlphabetNavigationControl: UIStackView {
    
    private var letters = [Character]()
    private var buttons = [UIButton]()
    var friends: [User]! { didSet { setupAlphabetButtons(for: friends)} }
    var delegate: AlphabetNavigationControlDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupControl()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupControl()
    }

    private func setupControl() {
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .equalCentering
        self.spacing = -10
    }
    
    func setupAlphabetButtons(for users: [User]) {
        prepareArrayOfLetters(for: users)
        setupButtons()
    }
    
    private func prepareArrayOfLetters(for users: [User]) {
        for user in users {
            guard let firstLetterChar = user.firstName.first else { continue }
            guard !letters.contains(firstLetterChar) else { continue }
            
            letters.append(firstLetterChar)
        }
    }
    
    private func setupButtons() {
        for letterChar in letters {
            let letter = String(letterChar).uppercased()
            
            let button = UIButton(type: .custom)
            button.setTitle(letter, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.setTitleColor(.gray, for: .normal)
            
            button.addTarget(self, action: #selector(onLetterTapped), for: .touchDown)
        
            addArrangedSubview(button)
        }
    }
    
    @objc func onLetterTapped(_ sender: UIButton) {
        delegate.onLetterTapped(sender)
    }
}

protocol AlphabetNavigationControlDelegate {
    func onLetterTapped(_ sender: UIButton)
}
