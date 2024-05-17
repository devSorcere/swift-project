//
//  UploadViewController.swift
//  Harwood
//
//  Created by Star on 5/7/24.
//

import UIKit
import Alamofire
import SwiftyJSON

class UploadViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var view_main: UIView!
    
    @IBOutlet weak var btn_import: UIButton!
    
    var userID: Int = 0
    var userToken = ""
    var userEmail = ""
    var userForm = "files"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var timer = 10
    
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
        view_main.layer.cornerRadius = 25
        btn_import.layer.cornerRadius = 30
        btn_import.layer.borderWidth = 2
        btn_import.layer.borderColor = UIColor.white.cgColor

    }
    
    func getDocumentsDirectly() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory

    }
    
    func selectFile() {
//        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
//        documentPicker.delegate = self
//        documentPicker.allowsMultipleSelection = false
//        present(documentPicker, animated: true, completion: nil)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    
    }
    
    
    func uploadFile(selectedImage: UIImage){
        let uploadURL = "https://dev.techsean.co.uk/api/upload"
        let parameters:[String:Any]=[
            "email":appDelegate.email,
            "user_id":appDelegate.id,
            "remember_token":appDelegate.token
        ]
        
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.4) else {
              print("Could not get JPEG representation of UIImage")
              return
          }
        
        AF.upload( multipartFormData: { multipartFormData in
//            multipartFormData.append( filePath, withName :"files")
            multipartFormData.append(imageData, withName: "files", fileName: "image.jpg", mimeType: "image/jpeg")
            for (key, value) in parameters {
                if let data = "\(value)".data(using: .utf8) {
                    multipartFormData.append(data, withName:key)
                    print("Please Upload File")
                    self.blurEffectView.frame = self.view_main.bounds
                    self.view_main.insertSubview(self.blurEffectView, at: 0)
                    
                    self.loadingAcitivityIndicator.center = CGPoint(x: self.view_main.bounds.midX, y: self.view_main.bounds.midY)
                    self.loadingAcitivityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
                    self.view_main.addSubview(self.loadingAcitivityIndicator)
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { Timer in
                        if self.timer > 0 {
                            self.timer -= 1
                            print("\(self.timer)")

                        } else {
                            Timer.invalidate()
                            print("Invalidate")
                            self.loadingAcitivityIndicator.removeFromSuperview()
                            self.blurEffectView.removeFromSuperview()
                        }
                    }
                }
            }
        }, to:uploadURL)
        .response { response in
            if let error = response.error{
                print("Upload failed with error: \(error)")
            } else {
                print("Upload successful: \(response)")
                let alert = UIAlertController(title: "Alert", message: "Uploaded Successful", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default , handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }

    }

    @IBAction func import_event(_ sender: Any) {

        selectFile()
    }
    
   
}

extension UploadViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          picker.dismiss(animated: true, completion: nil)
          
          if let selectedImage = info[.originalImage] as? UIImage {
              uploadFile(selectedImage: selectedImage)
          }
      }

      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          picker.dismiss(animated: true, completion: nil)
      }
}
