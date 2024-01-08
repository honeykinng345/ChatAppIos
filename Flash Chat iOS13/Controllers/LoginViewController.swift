//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
 

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBOutlet weak var indecatorView: UIActivityIndicatorView!
    @IBAction func loginPressed(_ sender: UIButton) {
        if (emailTextfield.text!.isEmpty) {
            HelperFunction.showSnakBar(view: self.view, message: "email required")
            return
            
        }
        if (passwordTextfield.text!.isEmpty) {
            HelperFunction.showSnakBar(view: self.view, message: "password required")
            return
            
        }
        indecatorView.isHidden = false
        indecatorView.hidesWhenStopped = true
        indecatorView.startAnimating()
        sender.isHidden = true
        sendRequestToServer(emailTextfield!.text!,passwordTextfield!.text!, sender)
    }
    
    func sendRequestToServer(_ email : String, _ pass : String,_ sender : UIButton) {
        Auth.auth().signIn(withEmail: email, password: pass) {authResult, error in
            if let e = error {
                HelperFunction.showSnakBar(view: self.view, message: e.localizedDescription)
            } else {
                self.performSegue(withIdentifier: ScreenRoutes.registerToChatScreen, sender: self)
            }
            
            sender.isHidden = false
            self.indecatorView.stopAnimating()
        }
        
    }
    
}
