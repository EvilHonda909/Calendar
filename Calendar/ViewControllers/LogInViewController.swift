//
//  AuthenticationController.swift
//  Calendar
//
//  Created by macintosh on 09/02/2021.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var signInButton : UIButton!
    @IBOutlet weak var errorLabel : UILabel!
    
    var signInTextFields : [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.signInTextFields = [self.emailTextField, self.passwordTextField]
        
        self.view.backgroundColor = .calendarBackground
        
        signInButton.backgroundColor = .calendarButton
        signInButton.setRoundedCorners(style: .highlyRounded)
        
        errorLabel.isHidden = true
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        signInTextFields.forEach { textField in
            textField.setTextFieldColorAndHideBorder()
            let bottomBorder = BottomBorder(frame: textField.bounds, color: .calendarBorderTextField)
            textField.layer.addSublayer(bottomBorder)
        }
        
        self.signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }
    
    @objc func signInTapped() {
        // Validate the text fields
        let errorLabelText = self.validateFields()
        if errorLabelText != nil {
            self.fillErrorLabelAndMakeVisible(errorLabelText!)
        } else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.fillErrorLabelAndMakeVisible("Error is occured during the signing up")
                } else {
                    
                    // Transition to the home screen
                    self.transitionToHomeScene()
                   }
            }
        }
    }
    
    func validateFields() -> String? {
        for textField in signInTextFields {
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
