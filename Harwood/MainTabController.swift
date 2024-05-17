//
//  MainTabController.swift
//  Harwood
//
//  Created by Star on 5/5/24.
//

import UIKit

class MainTabController: UITabBarController {
    
    var value = [Models]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate


    override func viewDidLoad() {
        super.viewDidLoad()
              print("Tab Controller")
        APIFetchHandler.sharedInstance.fetchAPIData {
            apiData in
            self.value = apiData
            print(self.value.count)
            // Appicon Badge show
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge], categories: nil))
            UIApplication.shared.applicationIconBadgeNumber = self.value.count
            // Save badge Data
            self.appDelegate.badgeCount = self.value.count 
            
            DispatchQueue.main.async {
            }
        }


    }
}
