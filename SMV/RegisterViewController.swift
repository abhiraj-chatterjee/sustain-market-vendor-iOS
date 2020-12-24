//
//  RegisterViewController.swift
//  SMV
//
//  Created by Abhiraj Chatterjee on 12/23/20.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    @IBOutlet weak var companyNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var addressLine1Field: UITextField!
    @IBOutlet weak var addressLine2Field: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var zipField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Hide the password text field
        passwordField.isSecureTextEntry = true
        confirmPasswordField.isSecureTextEntry = true
    }
    
    func validatePassword() -> Bool {
        return passwordField.text == confirmPasswordField.text
    }
    
    @IBAction func onSignup(_ sender: Any) {
        
        // trimmingCharacters(in: .whitespacesAndNewlines) ---> remove leading and trailing whitespaces, tabs, and newlines
        
        if validatePassword() {
            
            let newUser = PFUser()
            newUser.username = emailField.text
            newUser.password = passwordField.text
            newUser["company"] = companyNameField.text
            newUser["address1"] = addressLine1Field.text
            newUser["address2"] = addressLine2Field.text
            newUser["country"] = countryField.text
            newUser["city"] = cityField.text
            newUser["zip"] = zipField.text
            
            newUser.signUpInBackground { (success, error) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("Error: \(String(describing: error?.localizedDescription))")
                }
            }
        } else {
            
            let alertController = UIAlertController(title: "Error", message: "Passwords do not match.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Try Again", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func onCancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
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
