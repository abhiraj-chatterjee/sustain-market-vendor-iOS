//
//  NewProductViewController.swift
//  SMV
//
//  Created by Abhiraj Chatterjee on 12/23/20.
//

import UIKit
import AlamofireImage
import Parse

class NewProductViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var productDescriptionField: UITextField!
    @IBOutlet weak var productStockField: UITextField!
    @IBOutlet weak var productCostField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        
        let product = PFObject(className: "Products")
        
        product["name"] = productNameField.text!
        product["description"] = productDescriptionField.text!
        product["stock"] = productStockField.text!
        product["cost"] = productCostField.text!
        product["vendor"] = PFUser.current()!
        
        let imageData = productImageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        product["image"] = file
        
        product.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            } else {
                print("error!")
            }
        }
        
        
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        
        productImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
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
