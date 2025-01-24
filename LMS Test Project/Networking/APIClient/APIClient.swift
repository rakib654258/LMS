//
//  APIClient.swift
//
//  Created by Abdul Motalab Rakib on 23/9/24.
//

import Foundation
import Alamofire

protocol APIClient {
    func performRequest<T:Decodable>(
        route: APIEndpoint,
        decoder: JSONDecoder,
        completion:@escaping (AFResult<T>)->Void) -> DataRequest
}

extension APIClient {
    private func logResponse<T: Decodable>(_ response: DataResponse<T, AFError>) {
#if (DEBUG || PRODUCTION)
        Log.info("")
        Log.info("\nRequest Details:")
        if let urlRequest = response.request {
            Log.info("URL: \(String(describing: urlRequest.url))")
            if let method = urlRequest.method {
                Log.info("Request Method: \(method.rawValue)")
            }
            Log.info("Header:\n \(urlRequest.headers)")
            
            if let bodyData = urlRequest.httpBody?.prettyPrintedJSONString {
                Log.info("Body Data:\n \(bodyData)")
            }
        }
        Log.info("\nResponse Details:")
        Log.info("Status Code: \(String(describing: response.response?.statusCode))")
        if let responseData = response.data?.prettyPrintedJSONString {
            Log.info("Response Data:\n \(responseData)")
        }
#endif
    }
    @discardableResult
    func performRequest<T: Decodable>(route: APIEndpoint, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (AFResult<T>)->Void) -> DataRequest {
        
        return AF.request(route).responseDecodable(decoder: decoder) { (response: DataResponse<T, AFError>) in
            logResponse(response)
            completion(response.result)
        }
    }
    
    func performRequestWithSession(route: APIEndpoint, completion:@escaping((AFDataResponse<Data?>)->())) {
        APISessionManager.shared.sessionManagerLong.request(route).response { response in
            logResponse(response)
            completion(response)
        }
    }
    
    func startRequest(route: APIEndpoint, completion: @escaping (AFDataResponse<Data?>) -> Void)  {
         AF.request(route).response { response in
            logResponse(response)
            completion(response)
        }
    }
}

class APISessionManager {
    private init() { }
    
    static let shared = APISessionManager()
    
    lazy var sessionManagerLong : Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        return Session(configuration: configuration)
    }()
}
