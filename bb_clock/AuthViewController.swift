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
                enterButton.setTitle("enter", for: .normal)
                resetButton.isHidden = true
                alreadyLbl.text = "Already registered?"
                regButton.setTitle("Register me", for: .normal)
                repasswordTF.isHidden = false
            } else {
                mainLbl.text = "enter"
                nameTF.isHidden = true
                enterButton.setTitle("registration", for: .normal)
                resetButton.isHidden = false
                alreadyLbl.text = "Back to registration menu"
                regButton.setTitle("Enter the app", for: .normal)
                repasswordTF.isHidden = true
            }
        }
    }
    
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var repasswordTF: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var alreadyLbl: UILabel!
    @IBOutlet weak var regButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        repasswordTF.delegate = self
        resetButton.isHidden = true
    }
    
    @IBAction func enterBtnPressed(_ sender: UIButton) {
        signUpFlag = !signUpFlag
    }
    
    @IBAction func resetBtnPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func regBtnPressed(_ sender: UIButton) {
        let name = nameTF.text!
        let email = emailTF.text!
        let password = passwordTF.text!
        let repassword = repasswordTF.text!
        
        if signUpFlag {
            if !name.isEmpty && !email.isEmpty && !password.isEmpty && password == repassword {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if error == nil {
                        if let result = result {
                            //print(result.user.uid)
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["name" : name, "email": email])
                            self.dismiss(animated: true, completion: nil)
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
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    if error == nil {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            } else {
                showAlert()
            }
        }
    }
    
    //MARK: move to helper
    func showAlert() {
        let alert = UIAlertController(title: "Atention", message: "Please, make sure that fields are not empty!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: false, completion: nil)
    }
    
}

//MARK: implement k/b hiding actions
extension AuthViewController: UITextFieldDelegate {

}
