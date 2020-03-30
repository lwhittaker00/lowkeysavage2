//
//  ViewController.swift
//  lowkeysavage2
//
//  Created by User on 1/29/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    
    var webView: WKWebView!
    
    override func viewDidAppear(_ animated: Bool) {
        // 1
        let nav = self.navigationController?.navigationBar
        let tabs = self.tabBarController?.tabBar
    
        
        
        // 2
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.red
        tabs?.barStyle = UIBarStyle.black
        tabs?.tintColor = UIColor.red
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        imageView.contentMode = .scaleAspectFit
              
        // 4
        let image = UIImage(named: "headerlogotransparent")
        imageView.image = image
              
        // 5
        navigationItem.titleView = imageView
      
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        let url = URL(string: "https://l0wkeysavage.bigcartel.com/")!
        let request = URLRequest(url: url)
        webView.load(request)
          
        // 2
        
        self.navigationController?.isToolbarHidden = false
        navigationController?.toolbar.barTintColor = UIColor.lightGray
        navigationController?.toolbar.tintColor = UIColor.red
        var refreshBarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        let backButton = UIBarButtonItem(title: "<-", style: .plain, target: self, action: #selector(goBack))
        let forwardButton = UIBarButtonItem(title: "->", style: .plain, target: self, action: #selector(goForward))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        self.toolbarItems = [refreshBarButton, flexibleSpace, backButton, forwardButton]
        
        
        
//        if webView.isLoading {
//            let loader = UIActivityIndicatorView(style: .medium)
//            loader.startAnimating()
//            refreshBarButton = UIBarButtonItem(customView: loader)
//
//            //toolbarItems.
//        }
//        else {
//            refreshBarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
//        }

        // Do any additional setup after loading the view.
    }
    
    @objc func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc func refresh() {
        webView.reload()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //title = webView.title
        
    }
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
