//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth


class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var IndicatorView: UIActivityIndicatorView!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if HelperFunction.isInternetAvailable() {
            
            if (emailTextfield.text!.isEmpty) {
                HelperFunction.showSnakBar(view: self.view, message: "email required")
                return
                
            }
            if (passwordTextfield.text!.isEmpty) {
                HelperFunction.showSnakBar(view: self.view, message: "password required")
                return
                
            }
            let email = emailTextfield.text
            let pass = passwordTextfield.text
            IndicatorView.isHidden = false
            IndicatorView.hidesWhenStopped = true
            IndicatorView.startAnimating()
            sender.isHidden = true
            createUserAccount(email: email!, password: pass!) {authResult, error in
                if let e = error {
                    HelperFunction.showSnakBar(view: self.view, message: e.localizedDescription)
                } else {
                    HelperFunction.moveOnscreenToAnother(self, ScreenRoutes.registerToChatScreen)
                }
                
                sender.isHidden = false
                self.IndicatorView.stopAnimating()
            }
            
        } else {
            HelperFunction.showSnakBar(view: self.view, message: "Please check your internet connection.")
        }
    }
    func createUserAccount(email: String, password: String, completion: @escaping (AuthDataResult?,Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            completion(authResult,error)
        }
    }
    
    
    
}
