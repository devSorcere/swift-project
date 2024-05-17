//
//  PhotoViewController.swift
//  Harwood
//
//  Created by admin on 5/16/24.
//

import Foundation
import UIKit
import PDFKit
import WebKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var file_img_view: UIImageView!
    @IBOutlet weak var file_lbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var file_txt_view: UITextView!
    @IBOutlet weak var doc_view: WKWebView!
    
    @IBOutlet weak var pdfView: UIView!
    var custom_pdfView: PDFView!

    
    var file_name = ""
    var file_url = ""
    var text_flag = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view_main.layer.cornerRadius = 25
        self.file_lbl.text = file_name
        self.file_txt_view.isHidden = true
        self.pdfView.isHidden = true
        self.doc_view.isHidden = true
        
        custom_pdfView = PDFView()
        custom_pdfView.frame = pdfView.bounds
        pdfView.addSubview(custom_pdfView)
        let file_type = file_name.split(separator: ".")[file_name.split(separator: ".").count-1]
        if(file_type == "png" || file_type == "jpg" || file_type == "jpeg"){
            text_flag = 2
        }else if(file_type == "pdf"){
            text_flag = 3
        }
        else if(file_type == "doc" || file_type == "docx" || file_type == "xlsx"){
            text_flag = 4
        }
        else {
            text_flag = 1
        }
        activityIndicator.startAnimating()
//        text_flag = 4
        activityIndicator.color = UIColor.green
        if(text_flag == 4){
            self.file_txt_view.isHidden = true
            self.pdfView.isHidden = true
            self.file_img_view.isHidden = true
            self.doc_view.isHidden = false
            self.activityIndicator.isHidden = true
          
            let url = URL(string:file_url)
            let request = URLRequest(url:url!)
            self.doc_view.load(request)
        }
        else {
            fileData(text_url: file_url)
       }
    }
    
    @IBAction func back_Event(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func fileData(text_url:String){
        let url = URL(string:text_url)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                    }
                    if let error = error {
                        print("Error downloading file: \(error)")
                        return
                    }
                    guard let fileData = data else {
                        print("No data received")
                        return
                    }
                    DispatchQueue.main.async {
                        self.ImgTxtViewShow(flag: self.text_flag)
                    }
                    
                    if let fileContent = String(data: fileData, encoding: .utf8) {
                        DispatchQueue.main.async {
                            self.file_txt_view.text = fileContent
                        }
                    }
                    if let fileContent = UIImage(data: fileData) {
                        DispatchQueue.main.async {
                            self.file_img_view.image = fileContent
                        }
                    }
                    if let pdfDocument = PDFDocument(data: fileData) {
                        DispatchQueue.main.async {
                            self.custom_pdfView.document = pdfDocument
                        }
                    }
                }.resume() // Start the URLSession data task
    }
    
    func ImgTxtViewShow(flag: Int){
        self.file_img_view.isHidden =  flag==2 ? false : true
        self.file_txt_view.isHidden = flag==1 ? false : true
        self.pdfView.isHidden =  flag==3 ? false : true
    }
}
extension PhotoViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        var action: WKNavigationActionPolicy?
        defer {
            decisionHandler(action ?? .allow)
        }
        guard let url = navigationAction.request.url else { return}
        print ("decidePolicyFor - url: \(url)")
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("loading start")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        print("loading error")
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    func webView(_ webview: WKWebView, didFinish navigation: WKNavigation!){
        print("loading finished")
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
}
