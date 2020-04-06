//
//  adminWebViewController.swift
//  lowkeysavage2
//
//  Created by User on 4/4/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import WebKit

class adminWebViewController: UIViewController, WKNavigationDelegate {

    var webView2: WKWebView!
    
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
        webView2 = WKWebView()
        webView2.navigationDelegate = self
        view = webView2
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        let url = URL(string: "https://my.bigcartel.com/login")!
        let request = URLRequest(url: url)
        webView2.load(request)
          
        // 2
        
        self.navigationController?.isToolbarHidden = false
        navigationController?.toolbar.barTintColor = UIColor.lightGray
        navigationController?.toolbar.tintColor = UIColor.red
        var refreshBarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        let backButton = UIBarButtonItem(title: "<-", style: .plain, target: self, action: #selector(goBack))
        let forwardButton = UIBarButtonItem(title: "->", style: .plain, target: self, action: #selector(goForward))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        self.toolbarItems = [refreshBarButton, flexibleSpace, backButton, forwardButton]
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

    @objc func goBack() {
        if webView2.canGoBack {
            webView2.goBack()
        }
    }
    
    @objc func goForward() {
        if webView2.canGoForward {
            webView2.goForward()
        }
    }
    
    @objc func refresh() {
        webView2.reload()
    }
    
    func webView2(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //title = webView.title
        
    }
}
