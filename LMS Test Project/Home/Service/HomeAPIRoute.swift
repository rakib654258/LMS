//
//  UserValidationAPIRoute.swift
//
//  Created by Abdul Motalab Rakib on 24/9/24.
//

import Foundation
import Alamofire

enum HomeAPIRoute: APIEndpoint {
    case getWorldTeamProfileSummery
    case getSquadList
    
    private var baseURL: String {
        return AppConstants.Server.baseURL
    }
    
    private var apiVersion: String {
        return AppConstants.apiVersion.v1.rawValue
    }
    private var deviceType: Int {
        return AppConstants.App.deviceType
    }
    
    var path: String {
        switch self {
        case .getWorldTeamProfileSummery:
            baseURL + "GetWorldTeamProfileSummery?teamId=7027"
        case .getSquadList:
            baseURL + "GetWorldTeamProfile?typeId=4&teamId=7027"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getWorldTeamProfileSummery:
            return .get
        case .getSquadList:
            return .get
//        default:
//            return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getWorldTeamProfileSummery:
            return nil
        case .getSquadList:
            return nil
        }
    }
    
    var contentType: NetworkContentType? {
        return .json
    }
    
}
