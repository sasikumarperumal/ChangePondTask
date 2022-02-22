//
//  WebViewController.swift
//  ChangePondTask
//
//  Created by Sasikumar Perumal on 21/02/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var url = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // webview setup and load url
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            self.view.addSubview(webView)
            let url = URL(string: url)
            webView.load(URLRequest(url: url!))
    }

}
