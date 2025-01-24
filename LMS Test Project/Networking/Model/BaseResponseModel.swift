//
//  BaseResponseModel.swift
//
//  Created by Abdul Motalab Rakib on 23/9/24.
//

import Foundation

class BaseResponse: Codable {
    let status: ResponseStatus
    let apiName: String?
    let errorCode: Int?
    let errorMessage: String?
}

class Response<T: Decodable>: BaseResponse {
    let data: T?
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container.decodeIfPresent(T.self, forKey: .data)
        try super.init(from: decoder)
    }
}

enum ResponseStatus: Int, Codable {
    case failure = 0
    case success = 1
}
