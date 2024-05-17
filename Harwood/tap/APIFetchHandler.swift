//
//  APIFetchHandler.swift
//  Harwood
//
//  Created by Star on 5/12/24.
//

import Foundation
import Alamofire

class APIFetchHandler {
    static let sharedInstance = APIFetchHandler()
    var userEmail = ""
    var userToken = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func fetchAPIData(handler: @escaping(_ apiData:[Models]) -> Void){
        let url = "https://dev.techsean.co.uk/api/notification";
        userEmail = appDelegate.email
        userToken = appDelegate.token
        let urlString = URL.init(string: url)
        let parameter: Parameters = [
            "email": userEmail,
            "remember_token": userToken]
        AF.request(urlString!, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let json):
                print(json)
                do {
                    let jsonData1 = try JSONDecoder().decode([Models].self, from: json!)
                    print(jsonData1)
                    handler(jsonData1)
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

struct Models: Codable {
    let id: Int
    let email: String
    let message: String
    let msg_datetime: String
    let created_at:  String
    let updated_at: String
}
