//
//  MainPageViewController.swift
//  VK Client. Web interaction practice
//
//  Created by Aleksandr Malinin on 30.06.2021.
//

import UIKit

class MainPageViewController: UIViewController {
    
    var urlComponents = URLComponents()
    let configuration = URLSessionConfiguration.default
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = URLSession(configuration: configuration)
        
        loadInfo(session: session) {
            let apiAcess = VKApiServiceParams(schema: "https", host: "api.vk.com", path: "/method",methodToPath: "/photos.getAll")
            urlComponents.scheme = apiAcess.schema
            urlComponents.host = apiAcess.host
            urlComponents.path = apiAcess.path + apiAcess.methodToPath
            urlComponents.queryItems = [
                URLQueryItem(name: "owner_id", value: Singleton.shared.userId),
                URLQueryItem(name: "access_token", value: Singleton.shared.token),
                URLQueryItem(name: "v", value: "5.131")]
            let url = urlComponents.url!
            return url
        }


        loadInfo(session: session){
            let apiAcess = VKApiServiceParams(schema: "https", host: "api.vk.com", path: "/method",methodToPath: "/friends.get")
            urlComponents.scheme = apiAcess.schema
            urlComponents.host = apiAcess.host
            urlComponents.path = apiAcess.path + apiAcess.methodToPath
            urlComponents.queryItems = [
                URLQueryItem(name: "owner_id", value: Singleton.shared.userId),
                URLQueryItem(name: "fields", value: "nickname,domain,sex,bdate,city"),
                URLQueryItem(name: "access_token", value: Singleton.shared.token),
                URLQueryItem(name: "v", value: "5.131")]
            let url = urlComponents.url!
            return url
        }
        
        loadInfo(session: session){
            let apiAcess = VKApiServiceParams(schema: "https", host: "api.vk.com", path: "/method",methodToPath: "/groups.get")
            urlComponents.scheme = apiAcess.schema
            urlComponents.host = apiAcess.host
            urlComponents.path = apiAcess.path + apiAcess.methodToPath
            urlComponents.queryItems = [
                URLQueryItem(name: "owner_id", value: Singleton.shared.userId),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "access_token", value: Singleton.shared.token),
                URLQueryItem(name: "v", value: "5.131")]
            let url = urlComponents.url!
            return url
        }
    }
}


extension MainPageViewController {
    func loadInfo(session: URLSession, specifyInfo: () -> URL) {
        
        
        let url = specifyInfo()
        
        let task = session.dataTask(with: urlComponents.url!){data, response, error
            in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            print (json)
        }
        task.resume()
    }

}
