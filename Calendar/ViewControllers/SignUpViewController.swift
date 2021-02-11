//
//  SignUpViewController.swift
//  Calendar
//
//  Created by macintosh on 09/02/2021.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField : UITextField!
    @IBOutlet weak var lastNameTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var signUpButton : UIButton!
    @IBOutlet weak var errorLabel : UILabel!
    
    var signUpInfoTextFields : [UITextField]!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpInfoTextFields = [self.firstNameTextField,
                                self.lastNameTextField,
                                self.emailTextField,
                                self.passwordTextField]
        
        self.view.backgroundColor = .calendarBackground
        
        self.signUpButton.backgroundColor = .calendarButton
        self.signUpButton.setRoundedCorners(style: .highlyRounded)
        self.signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        self.errorLabel.isHidden = true
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        signUpInfoTextFields.forEach { textField in
            textField.setTextFieldColorAndHideBorder()
            let bottomBorder = BottomBorder(frame: textField.bounds, color: .calendarBorderTextField)
            textField.layer.addSublayer(bottomBorder)
        }
    }
    
    @objc func signUpTapped() {
        // Validate the text fields
        let errorLabelText = self.validateFields()
        if errorLabelText != nil {
            self.fillErrorLabelAndMakeVisible(errorLabelText!)
        } else {
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.fillErrorLabelAndMakeVisible("Error is occured during the signing up")
                } else {
                     // No errors but we save some additional user's information
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data:
                                                        ["firstName" : firstName,
                                                         "lastName" : lastName,
                                                         "uid" : result!.user.uid]) { error in
                        if error != nil {
                            self.fillErrorLabelAndMakeVisible("Error is occured during the process of addition user info to the server")
                        }
                        
                    }
                    // Transition to the home screen
                    self.transitionToHomeScene()
                   }
            }
        }
    }
    
    func validateFields() -> String? {
        for textField in signUpInfoTextFields {
            if textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Fill All Fields, Please"
            }
        }
        return nil
    }
    
    func fillErrorLabelAndMakeVisible(_ errorText: String) {
        errorLabel.text = errorText
        errorLabel.isHidden = false
    }
    
    func transitionToHomeScene() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? CalendarViewController
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()

    }
    
}

