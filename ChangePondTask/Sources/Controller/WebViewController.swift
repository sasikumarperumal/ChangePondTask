//
//  WebViewController.swift
//  ChangePondTask
//
//  Created by Sasikumar Perumal on 21/02/22.
//

import UIKit
import WebKit
import RSLoadingView

class WebViewController: UIViewController,WKUIDelegate,WKNavigationDelegate {
    
    var url = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            RSLoadingView().showOnKeyWindow()
        }
        
        // webview setup and load url
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        webView.navigationDelegate = self
        webView.uiDelegate = self
            self.view.addSubview(webView)
            let url = URL(string: url)
            webView.load(URLRequest(url: url!))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
                RSLoadingView.hideFromKeyWindow()
            }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
                RSLoadingView.hideFromKeyWindow()
            }
    }
    
}
