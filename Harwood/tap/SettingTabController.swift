//
//  SettingTabController.swift
//  Harwood
//
//  Created by Star on 5/5/24.
//

import UIKit

class SettingTabController: UIViewController {
    
    @IBOutlet weak var view_main: UIView!
    
    @IBOutlet weak var notification_setting: UISwitch!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view_main.layer.cornerRadius = 25
        notification_setting.isOn = true
    }
    
    @IBAction func notification_event(_ sender: Any) {
        if notification_setting.isOn {
            print("Switch On")
            appDelegate.notification = true
        } else {
            print("Switch Off")
            appDelegate.notification = false
        }
        
    }
}
