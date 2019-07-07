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
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo as NSDictionary?
        let keyboardSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWasHidden(notification: Notification) {
        
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @IBAction func onLogInButtonPressed(_ sender: UIButton) {

    }
    
    @IBAction func onBackgroundTapped(_ sender: UITapGestureRecognizer) {
        
        //hiding keayboard
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    fileprivate func showLoginError() {
        let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if isIdentityConfirmed() {
            return true
        } else {
            showLoginError()
            return false
        }
    }
    
    func isIdentityConfirmed() -> Bool {
        
        //TODO: Create real identity check implementation
        return loginTextField.text == "" && passwordTextField.text == ""
    }
}

extension LoginController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField === loginTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField === passwordTextField {
//            passwordTextField.resignFirstResponder()
            if shouldPerformSegue(withIdentifier: "loginSegue", sender: self) {
                performSegue(withIdentifier: "loginSegue", sender: self)
            }
        }
        
        return true
    }
}

