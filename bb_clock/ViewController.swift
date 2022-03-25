//
//  ViewController.swift
//  bb_clock
//
//  Created by Даурен on 25.03.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do { try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

