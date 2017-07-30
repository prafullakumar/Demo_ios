//
//  WebViewController.swift
//  Test
//
//  Created by prafulla on 30/07/17.
//  Copyright © 2017 HelloDoc. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    var url : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Details"
        webView.delegate = self
        webView.loadRequest(URLRequest.init(url: URL.init(string: url)!))
        self.showHood(footerMessage: "Loading Details...")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.hideHood()
    }

}
