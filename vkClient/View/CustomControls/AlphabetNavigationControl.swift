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
    var tableView: UITableView!
    var friends: [User]!
    
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
        friends = users
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
    
    @objc private func onLetterTapped(_ sender: UIButton) {
        guard tableView != nil else { fatalError("did not assign tableView") }
        guard let letter = sender.title(for: .normal) else { return }
        
        var index: Int?
        for i in 0..<friends.count {
            guard let first = friends[i].firstName.first else { continue }
            if String(first) == letter {
                index = i
                break
            }
        }
        #warning("fix scrolling considering sections")
        guard let row = index else { return }
        let indexPath = IndexPath(row: row, section: tableView.numberOfSections - 1)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
