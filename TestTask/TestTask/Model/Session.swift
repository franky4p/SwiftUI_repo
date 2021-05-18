//
//  Session.swift
//  TestTask
//
//  Created by macbook on 14.05.2021.
//
import Foundation

final class Session {
    let session =  URLSession(configuration: URLSessionConfiguration.default)

    static let shared = Session()
    
    private init() {}
    
    func requestToAPI<T: Decodable>(url: URLRequest, typeReceiver: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = self.session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
//            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
//            print(json ?? "нет данных")
            
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

final class RequestServis {
    static let scheme: String = "https"
    static let hostAPI: String = "alpha.as50464.net"
    static let uid: String = "563B4852-6D4B-49D6-A86E-B273DD520FD2"
    static let rid: String = "BEYkZbmV"
    static let type: String = "ExchangeRates"
    
    static func requestExchangeRates() -> URLRequest {
        let bodyRequest = BodyRequest(uid: uid, rid: rid, type: type)
        let encoder = JSONEncoder()
        let data = try! encoder.encode(bodyRequest)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = hostAPI
        urlComponents.path = "/moby-pre-44/core"
        urlComponents.port = 29870
        urlComponents.queryItems = [
            URLQueryItem(name: "r", value: rid),
            URLQueryItem(name: "d", value: uid),
            URLQueryItem(name: "t", value: type),
            URLQueryItem(name: "v", value: "44")
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.httpBody = data
        request.allHTTPHeaderFields = ["User-Agent" : "Test GeekBrains iOS 3.0.0.182 (iPhone 11; iOS 14.4.1; Scale/2.00; Private)",
                                       "Content-Type": "application/json",
                                       "Accept": "application/json"]
        
        return request
    }
}

func updateFromServer(_ viewModel: ModelView) {
    let opq = OperationQueue()
    let requestExchangeRates = RequestServis.requestExchangeRates()
    
    let opRates = GetDataOperation(request: requestExchangeRates, typeDate: ExchangeRate.self)
    opRates.completionBlock = {
        //print(opRates.data)
        viewModel.updateRates(opRates.data)
    }
    
    opq.addOperation(opRates)
}

struct BodyRequest: Codable {
    let uid: String
    let rid: String
    let type: String
}
