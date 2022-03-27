//
//  ResetPasswordViewController.swift
//  bb_clock
//
//  Created by Даурен on 27.03.2022.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetButtnoPressed(_ sender: UIButton) {
        let email = emailTF.text!
        if !email.isEmpty {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error == nil {
                    //джяй заглушка
                    print("done")
                } else {
                    print(error?.localizedDescription as Any)
                }
            }
        }

    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
