//
//  APICategoryhandler.swift
//  Harwood
//
//  Created by Star on 5/13/24.
//

import Foundation
import Alamofire
import SwiftyJSON

class APICategoryhandler {
    
    static let sharedInstance = APICategoryhandler()
    
    var userID: Int = 0
    var userToken = ""
    var userCategory = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func fetchAPIData(handler: @escaping(_ apiData:[ModelCategoryApi]) -> Void){
        let url = "https://dev.techsean.co.uk/api/category";
        userToken = appDelegate.token
        userCategory = appDelegate.categoryName
        userID = appDelegate.id
        let urlString = URL.init(string: url)
        let parameter: Parameters = [
            "user_id": userID,
            "category_name": userCategory,
            "remember_token": userToken]
        AF.request(urlString!, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let json):
                print(json)
                do {
                    let jsonData = try JSONDecoder().decode([ModelCategoryApi].self, from: json!)
                    print(jsonData)
                    handler(jsonData)
                } catch {
                    print(error.localizedDescription)
                }
                
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
}


struct ModelCategoryApi: Codable {
    let id: Int
    let user_id: Int
    let email: String
    let category: String
    let path: String
    let filename: String
    let base_path: String
    let hashname: String
    let role: String
    let created_at:  String
    let updated_at: String
}
