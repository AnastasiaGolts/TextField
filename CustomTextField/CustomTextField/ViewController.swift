//
//  ViewController.swift
//  CustomTextField
//
//  Created by Anastasia G on 09.02.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textFieldTwo: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldTwo.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



