//
//  VKLoginPageViewController.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 25.06.2021.
//

import UIKit
import WebKit
import Alamofire


class VKLoginPageViewController: UIViewController {
    
    
    @IBOutlet weak var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }
    
    var urlComponents = URLComponents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7888664"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "friends,photos,groups,notes"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131")]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webview.load(request)
    }
}


extension VKLoginPageViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }

        
        let params = fragment.components(separatedBy: "&").map{$0.components(separatedBy: "=")}.reduce([String:String]()){empty_dict,param in
            var dict = empty_dict
            let key = param[0]
            let value = param[1]
            dict[key] = value
            return dict
        }

        
        let token = params["access_token"]
        let userid = params["user_id"]
        
        
        if let tokenString = token, let useridString = userid {
            saveUserInfo(receivedUserId: useridString,receivedToken: tokenString)}
        
        
        let someToken = Singleton.shared.token
        let someUserId = Singleton.shared.userId
        print("For user \(someUserId). This is token: \(someToken)")
        
        
        decisionHandler(.cancel)
        toNextScreen()
    }
}


extension VKLoginPageViewController {
    func saveUserInfo(receivedUserId userId: String, receivedToken token: String) -> Void {
        Singleton.shared.userId = userId
        Singleton.shared.token = token
    }
}


extension VKLoginPageViewController {
    func toNextScreen(){
        performSegue(withIdentifier: "ToMainScreen", sender: nil)
    }
}




//extension VKLoginPageViewController{
//
//    func loadUrl(){
//        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration)
//        let apiAcess = VKApiServiceParams(schema: "https", host: "api.vk.com", path: "/method",methodToPath: "/photos.getAll")
//
//        urlComponents.scheme = apiAcess.schema
//        urlComponents.host = apiAcess.host
//        urlComponents.path = apiAcess.path + apiAcess.methodToPath
//        urlComponents.queryItems = [
//                                    URLQueryItem(name: "owner_id", value: Singleton.shared.userId),
//                                    URLQueryItem(name: "access_token", value: Singleton.shared.token),
//                                    URLQueryItem(name: "v", value: "5.131")]
//
//
//        let task = session.dataTask(with: urlComponents.url!){data, response, error
//            in
//            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
//            print (json)
//        }
//        task.resume()
//    }
//
//}







    
    
    


