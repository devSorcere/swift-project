//
//  CategoryTabController.swift
//  Harwood
//
//  Created by Star on 5/5/24.
//

import UIKit
import Alamofire
import SwiftyJSON
import UserNotifications



class NotificationTabController: UIViewController {
    
    @IBOutlet weak var view_main: UIView!
    var value = [Models]()
    var selectedIndex = IndexPath()
        
    
    @IBOutlet weak var tbl_notification: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var expandedCells = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFetchHandler.sharedInstance.fetchAPIData {
            apiData in
            self.value = apiData
            print(self.value.count)
            // Appicon Badge show
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge], categories: nil))
            UIApplication.shared.applicationIconBadgeNumber = self.value.count
            
            DispatchQueue.main.async {
                self.tbl_notification.reloadData()
            }
        }
        view_main.layer.cornerRadius = 30
        tbl_notification.dataSource = self
        tbl_notification.delegate = self
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Tab badget Show
        if let tabItems = self.tabBarController?.tabBar.items {
            let tabItem = tabItems[1]
            tabItem.badgeValue = "\(self.appDelegate.badgeCount)"
        }
        
    }
    
}

extension NotificationTabController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cellID = tbl_notification.dequeueReusableCell(withIdentifier: "notificationCellID")
        else {
           return UITableViewCell()
       }
        if appDelegate.notification == true {
            cellID.textLabel?.text = value[indexPath.row].message + "    \(value[indexPath.row].msg_datetime)"
            cellID.textLabel?.lineBreakMode = .byWordWrapping
            cellID.textLabel?.numberOfLines = 3
            cellID.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
            
        } else if appDelegate.notification == false {
            value.removeAll()
            self.tbl_notification.reloadData()
        }
        return cellID
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndex {
            return 100
        }
        return 25
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select\(indexPath.row)")
        selectedIndex = indexPath
        tbl_notification.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }
}
