//
//  ViewController.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 28/06/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onLogInButtonPressed(_ sender: UIButton) {
        print("\"Log in\" button pressed")
    }
    
}

