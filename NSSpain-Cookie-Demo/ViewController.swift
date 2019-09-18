//
//  ViewController.swift
//  NSSpain Cookie Demo
//
//  Created by Dominik Scherm on 18.09.19.
//  Copyright © 2019 FirstBlink. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cookie = HTTPCookie(properties: [
            .domain: "localhost",
            .path: "/",
            .port: "3000",
            .name: "connect.sid",
            .version: 1,
            //Paste here your session cookie value
            .value: "s%3AMiWc_IMtqeEN5w1d02wwXOMkCN43jU9N.27819NzjsnG%2Bd5d%2B9qyj2rCfC91Gte0Q%2F1r8lrCce4A"])
        
        let websiteDataStore = WKWebsiteDataStore.nonPersistent()
        websiteDataStore.httpCookieStore.setCookie(cookie!) {
            let config = WKWebViewConfiguration()
            config.websiteDataStore = websiteDataStore
            
            self.webView = WKWebView(frame: self.view.frame, configuration: config)
            self.view = self.webView
            self.webView!.navigationDelegate = self
            self.webView!.load(URLRequest(url: URL(string: "http://localhost:3000/profile")!))
        }
    }
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        self.webView!.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                print(cookie)
            }
        }
    }
}
