//
//  LoginWebViewController.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/12/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    let activitySpinner = SpinnerViewController()
    
    var url : URL? {
        let query = VKQueryType.authorize
        var urlComponents = URLComponents(string: query.URLString)
        urlComponents?.queryItems = query.parameters.map { URLQueryItem(name: $0, value: "\($1)") }
        return urlComponents?.url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let url = url else { return }
        print(url)
        webView.load(URLRequest(url: url ))
    }
    
    
    func activityStart() {
        addChild(activitySpinner)
        activitySpinner.view.frame = view.frame
        view.addSubview(activitySpinner.view)
        activitySpinner.didMove(toParent: self)
    }
    
    
    func activityStop() {
        if activitySpinner.spinner.isAnimating {
            activitySpinner.willMove(toParent: nil)
            activitySpinner.view.removeFromSuperview()
            activitySpinner.removeFromParent()
        }
    }
    
}

extension LoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityStop()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityStart()
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityStop()
        AuthService.signIn(url: webView.url)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
}

