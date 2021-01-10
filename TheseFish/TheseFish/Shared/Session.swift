//
//  Session.swift
//  TheseFish
//
//  Created by macbook on 08.01.2021.
//

import Foundation


final class Session {
    let session =  URLSession(configuration: URLSessionConfiguration.default)
    static let shared = Session()
    private init() {}
    
    func requestToAPI<T: Decodable>(url: URLRequest, typeReceiver: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = self.session.dataTask(with: url) { (data, response, error) in
//                        let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves)
//            print(json ?? "shlyapa")
            guard let data = data else { return }

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            do {
                let results = try JSONDecoder().decode(T.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(results))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
        }
        task.resume()
    }
    
}

final class RequestWiki {
    static let scheme: String = "https"
    static let host: String = "ru.wikipedia.org"
    static let path: String = "/w/api.php"
    
    static func requestRegionFish() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "list", value: "categorymembers"),
            URLQueryItem(name: "cmtitle", value: "Категория:Рыбы_по_регионам"),
            //URLQueryItem(name: "redirect_uri", value: "https://ru.wikipedia.org/wiki"),
            URLQueryItem(name: "format", value: "json")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        return request
    }
}
