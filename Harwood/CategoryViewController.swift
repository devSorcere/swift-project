//
//  CategoryViewController.swift
//  Harwood
//
//  Created by Star on 5/7/24.
//

import UIKit
import Alamofire
import SwiftyJSON

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var lbl_category: UILabel!
    @IBOutlet weak var view_main: UIView!
    var categoryText = ""
    var value = [ModelCategoryApi]()
    var selectedIndex = IndexPath()

    
    @IBOutlet weak var tbl_category: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view_main.layer.cornerRadius = 25
        lbl_category.text = categoryText
        
        APICategoryhandler.sharedInstance.fetchAPIData {
            apiData in
            self.value = apiData
            
            DispatchQueue.main.async {
                self.tbl_category.reloadData()
            }
        }
        tbl_category.delegate = self
        tbl_category.dataSource = self
    }
    
    @IBAction func back_Event(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tbl_category.dequeueReusableCell(withIdentifier: "categoryviewID") as! CategoryCustomCell
        cell.view_preview.layer.cornerRadius = 10
        cell.view_preview.layer.borderWidth = 2
        cell.view_preview.layer.borderColor = UIColor.white.cgColor
        cell.view_filename.layer.cornerRadius = 10
        cell.lbl_filename.text = value[indexPath.row].filename
        cell.btn_preview.tag = indexPath.row
        cell.btn_preview.addTarget(self, action: #selector(ItemSelected), for: .touchUpInside)
        return cell
    }
    
    @objc func ItemSelected(sender: UIButton) {
        print("select\(self.value[sender.tag])")
        let selected_obj = self.value[sender.tag]
        let category = storyboard?.instantiateViewController(withIdentifier: "photoVC") as! PhotoViewController
        category.file_url = selected_obj.base_path + selected_obj.hashname
        category.file_name = selected_obj.filename
        self.navigationController?.pushViewController(category, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex == indexPath {
            print("select\(self.value[indexPath.row])")
        }
        print("select\(self.value[indexPath.row])")
        let selected_obj = self.value[indexPath.row]
//        let category = storyboard?.instantiateViewController(withIdentifier: "photoVC") as! PhotoViewController
//        category.file_url = selected_obj.base_path + selected_obj.hashname
//        category.file_name = selected_obj.filename
////        category.file_info = ModelCategoryApi(selected_obj)
//        self.navigationController?.pushViewController(category, animated: true)
    }
}

