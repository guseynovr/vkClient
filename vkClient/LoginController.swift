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
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func onLogInButtonPressed(_ sender: UIButton) {
        print("\"Log in\" button pressed")
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        
        //hiding keayboard
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

extension LoginController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField === loginTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField === passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        
        return true
    }
}

