//
//  SignInViewController.swift
//  Financies
//
//  Created by Juan on 12/26/19.
//  Copyright © 2019 Juan. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var GoogleSignInButton: GIDSignInButton!
    
    private var viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.authAccountKit(sender: self) { (success, error) in
            
        }
    }
    
    @IBAction func SignIn(_ sender: Any) {
        SignInViewModel.signInWith(email: emailTextField.text, password: passwordTextField.text) { [weak self] (success, error) in
            if let error = error {
                let alert = UIAlertController(title: "ERROR!", message: error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            if success {
                self?.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
    }
    
    @IBAction func facebookLogin(_ sender: Any) {
        SignInViewModel.facebookLogin(viewController: self, handler: { [weak self] (success, error) in
            if let error = error {
                let alert = UIAlertController(title: "ERROR!", message: error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            if success {
                self?.performSegue(withIdentifier: "goToMain", sender: self)
            }
        })
    }
    
    @IBAction func SignInWithGoogle(_ sender: Any) {
        func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                    withError error: NSError!) {
            if (error == nil) {
                // Perform any operations on signed in user here.
                // ...
            } else {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func authWithTwitter(_ sender: Any) {
        SignInViewModel.authWithTwitter { [weak self] (success, error) in
            if let error = error {
                let alert = UIAlertController(title: "ERROR!", message: error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            if success {
                self?.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
