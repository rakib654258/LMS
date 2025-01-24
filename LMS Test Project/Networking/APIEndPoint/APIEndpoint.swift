//
//  APIEndpoint.swift
//
//  Created by Abdul Motalab Rakib on 23/9/24.
//

import Foundation
import Alamofire

protocol APIEndpoint: URLRequestConvertible, URLConvertible {
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var parameters: Parameters? { get }
    var bodyData: Data? { get }
    var contentType: NetworkContentType? { get }
    
    func asURLRequest() throws -> URLRequest
    func asURL() throws -> URL
}

extension APIEndpoint {
    var contentType: NetworkContentType? { .json }
    var parameters: Parameters? { nil }
    var bodyData: Data? { nil }
}

extension APIEndpoint  {
    private func queryItems(_ key: String, _ value: Any?) -> [URLQueryItem] {
        var result = [] as [URLQueryItem]
        
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                result += queryItems("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            let arrKey = key
            for value in array {
                result += queryItems(arrKey, value)
            }
        } else if let value = value {
            result.append(URLQueryItem(name: key, value: "\(value)"))
        } else {
            result.append(URLQueryItem(name: key, value: nil))
        }
        
        return result
    }
    
    // Encodes complex [String: AnyObject] params into array of URLQueryItem
    internal func paramsToQueryItems(_ params: [String: Any]?) -> [URLQueryItem]? {
        guard let params = params else { return nil }
        
        var result = [] as [URLQueryItem]
        
        for (key, value) in params {
            result += queryItems(key, value)
        }
        return result
    }
    
    func asURLRequest() throws -> URLRequest {
        var httpBody: Data?
        if let parameters = parameters {
            do {
                httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        } else if let bodyData = bodyData {
            httpBody = bodyData
        }
        
        var urlComponents = URLComponents(string: path)!
        
        if let items = paramsToQueryItems(parameters) {
            urlComponents.queryItems = items
        }
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = httpBody
        
        if let contentType = contentType?.rawValue {
            urlRequest.setValue(contentType, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        }
        
        return urlRequest
    }
    
    /// Default  implementation, you can always provide your own
    func asURL() throws -> URL {
        let url = URL(string: path)!
        return url
    }
}
