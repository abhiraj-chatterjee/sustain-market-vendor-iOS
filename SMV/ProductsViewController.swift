//
//  ProductsViewController.swift
//  SMV
//
//  Created by Abhiraj Chatterjee on 12/23/20.
//

import UIKit
import Parse
import AlamofireImage

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var productsTableView: UITableView!
    
    var products = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Products")
        query.whereKey("vendor", equalTo: PFUser.current() as Any)
        query.limit = 20
        
        query.findObjectsInBackground { (products, error) in
            if products != nil {
                self.products = products!
                self.productsTableView.reloadData()
            }
            DispatchQueue.main.async {
                self.productsTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
        
        let product = products[indexPath.row]
        cell.productNameLabel.text = (product["name"] as! String)
        cell.productStockLabel.text = "(" + (product["stock"] as! String) + " units)"
        cell.productPriceLabel.text = "$" + (product["cost"] as! String)
        cell.productDescriptionLabel.text = (product["description"] as! String)
        
        let imageFile = product["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.productPhotoView.af.setImage(withURL: url)
        
        return cell
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
