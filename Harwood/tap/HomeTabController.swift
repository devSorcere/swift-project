//
//  HomeTabController.swift
//  Harwood
//
//  Created by Star on 5/5/24.
//

import UIKit

class HomeTabController: UIViewController {
    
    @IBOutlet weak var view_main: UIView!
    
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var btn_category7: UIButton!
    @IBOutlet weak var btn_category6: UIButton!
    @IBOutlet weak var btn_category5: UIButton!
    @IBOutlet weak var btn_category4: UIButton!
    @IBOutlet weak var btn_category3: UIButton!
    @IBOutlet weak var btn_category2: UIButton!
    @IBOutlet weak var btn_category1: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view_main.layer.cornerRadius = 30
        lbl_name.text = appDelegate.profileName
        btn_category1.layer.cornerRadius = 25
        btn_category2.layer.cornerRadius = 25
        btn_category3.layer.cornerRadius = 25
        btn_category4.layer.cornerRadius = 25
        btn_category5.layer.cornerRadius = 25
        btn_category6.layer.cornerRadius = 25
        btn_category7.layer.cornerRadius = 25
    }
    
    @IBAction func category1_event(_ sender: Any) {
        
        let category = storyboard?.instantiateViewController(withIdentifier: "categoryVC") as! CategoryViewController
        category.categoryText = "Reports"
        appDelegate.categoryName = "report"
        self.navigationController?.pushViewController(category, animated: true)
        
    }
    
    @IBAction func category2_event(_ sender: Any) {
        let category = storyboard?.instantiateViewController(withIdentifier: "categoryVC") as! CategoryViewController
        category.categoryText = "Valuations"
        appDelegate.categoryName = "valuation"
        self.navigationController?.pushViewController(category, animated: true)
    
    }
    
    @IBAction func category3_event(_ sender: Any) {
        let category = storyboard?.instantiateViewController(withIdentifier: "categoryVC") as! CategoryViewController
        category.categoryText = "illustrations"
        appDelegate.categoryName = "illustration"
        self.navigationController?.pushViewController(category, animated: true)
    
    }
    
    @IBAction func category4_event(_ sender: Any) {
        let category = storyboard?.instantiateViewController(withIdentifier: "categoryVC") as! CategoryViewController
        category.categoryText = "Plan Documents"
        appDelegate.categoryName = "plan"
        self.navigationController?.pushViewController(category, animated: true)
    
    }
    
    @IBAction func category5_event(_ sender: Any) {
        let category = storyboard?.instantiateViewController(withIdentifier: "categoryVC") as! CategoryViewController
        category.categoryText = "Wills/Powers of Attorney(POA)"
        appDelegate.categoryName = "POA"
        self.navigationController?.pushViewController(category, animated: true)
    
    }
    
    @IBAction func category6_event(_ sender: Any) {
        let category = storyboard?.instantiateViewController(withIdentifier: "categoryVC") as! CategoryViewController
        category.categoryText = "Insurance policies"
        appDelegate.categoryName = "insurance"
        self.navigationController?.pushViewController(category, animated: true)
    }
    
    @IBAction func category7_event(_ sender: Any) {
        let category = storyboard?.instantiateViewController(withIdentifier: "categoryVC") as! CategoryViewController
        category.categoryText = "HFP Documents"
        appDelegate.categoryName = "HFP"
        self.navigationController?.pushViewController(category, animated: true)
    
    }
    
    
}
