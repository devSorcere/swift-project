//
//  ViewController.swift
//  Harwood
//
//  Created by Star on 5/5/24.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    
    var name = ""
    var timer = 3
    let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
   
    var loadingAcitivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        
        return indicator
    }()
    
    var blurEffectView: UIVisualEffectView = {
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight]
        
        return blurEffectView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txt_email.layer.cornerRadius = 25
        txt_password.layer.cornerRadius = 25
        btn_login.layer.cornerRadius = 25
        txt_email.delegate = self
        txt_password.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewwillappear")
        txt_email.text = appDelegate.rememberEmail

    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_email {
            textField.resignFirstResponder()
            txt_password.becomeFirstResponder()
        } else if textField == txt_password {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func login_event(_ sender: Any) {
        
        let url = "https://dev.techsean.co.uk/api/login";
        let urlString = URL.init(string: url)
        let parameter: Parameters = [
            "email": txt_email.text!,
            "password": txt_password.text!,
            "name": name]
        AF.request(urlString!, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { (response) in
            print(response)
            switch response.result {
            case .success(let json):
                let username = self.txt_email.text
                let userpassword = self.txt_password.text
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set(userpassword, forKey: "userpassword")
                let jsonData = JSON(json)
                let token_rembember = JSON(json)["remember_token"]
                let user_email = JSON(json)["user"]["email"]
                let user_id = JSON(json)["user"]["id"]
                let username1 = JSON(json)["user"]
                let username2 = username1["name"]
                self.name = username2.description
                self.appDelegate.profileName = self.name
                self.appDelegate.token = token_rembember.description
                self.appDelegate.email = user_email.description
                self.appDelegate.id = Int(user_id.description)!
                print("\(self.name)")
                self.blurEffectView.frame = self.view.bounds
                self.view.insertSubview(self.blurEffectView, at: 0)
                
                self.loadingAcitivityIndicator.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
                self.loadingAcitivityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
                self.view.addSubview(self.loadingAcitivityIndicator)
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { Timer in
                    if self.timer > 0 {
                        self.timer -= 1
                        print("\(self.timer)")

                    } else {
                        Timer.invalidate()
                        print("Invalidate")
                        self.loadingAcitivityIndicator.removeFromSuperview()
                        let main = self.storyboard1.instantiateViewController(withIdentifier: "mainVC") as! MainTabController
                        self.navigationController?.pushViewController(main, animated: true)
                    }
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }

}

struct Model: Codable {
    let userName: String
    let id: Int
    let email: String
}


