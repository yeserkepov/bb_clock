//
//  RegistrationViewController.swift
//  bb_clock
//
//  Created by Даурен on 25.03.2022.
//

import UIKit
import Firebase
import FirebaseDatabase

class AuthViewController: UIViewController {
    
    var signUpFlag: Bool = true {
        willSet {
            if newValue {
                mainLbl.text = "registration"
                nameTF.isHidden = false
                enterBTN.setTitle("enter", for: .normal)
            } else {
                mainLbl.text = "enter"
                nameTF.isHidden = true
                enterBTN.setTitle("registration", for: .normal)
            }
        }
    }
    
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var repasswordTF: UITextField!
    @IBOutlet weak var enterBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        repasswordTF.delegate = self
    }
    
    @IBAction func enterBtnPressed(_ sender: UIButton) {
        signUpFlag = !signUpFlag
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let name = nameTF.text!
        let email = emailTF.text!
        let password = passwordTF.text!
        
        if signUpFlag {
            if !name.isEmpty && !email.isEmpty && !password.isEmpty {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if error == nil {
                        if let result = result {
                            print(result.user.uid)
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["name" : name, "email": email])
                        }
                    } else {
                        print(error?.localizedDescription as Any)
                    }
                }
            } else {
                showAlert()
            }
        } else {
            if !email.isEmpty && !password.isEmpty {
                
            } else {
                showAlert()
            }
        }
        return true
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Atention", message: "Please, make sure that fields are not empty!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: false, completion: nil)
    }
}
