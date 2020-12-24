//
//  ProfileViewController.swift
//  SMV
//
//  Created by Abhiraj Chatterjee on 12/24/20.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyEmailLabel: UILabel!
    @IBOutlet weak var companyAddressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupProfile()
    }
    
    func setupProfile() {
        let currentUser = PFUser.current()!
        companyNameLabel.text = (currentUser["company"] as! String)
        companyEmailLabel.text = (currentUser.username!)
        companyAddressLabel.text = (currentUser["address1"] as! String) + "\n" + (currentUser["city"] as! String) + ", " + (currentUser["country"] as! String)
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        
        sceneDelegate.window?.rootViewController = loginViewController
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
