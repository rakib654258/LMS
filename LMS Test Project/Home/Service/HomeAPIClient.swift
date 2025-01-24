//
//  UserValidationAPIClient.swift
//
//  Created by Abdul Motalab Rakib on 24/9/24.
//

import Foundation
import Alamofire

class HomeAPIClient: APIClient {
    func getWorldTeamProfileSummery( completion: @escaping (AFDataResponse<Data?>) -> () ) {
        let route = HomeAPIRoute.getWorldTeamProfileSummery
        performRequestWithSession(route: route, completion: completion)
    }
    func getSquadList( completion: @escaping (AFDataResponse<Data?>) -> () ) {
        let route = HomeAPIRoute.getSquadList
        performRequestWithSession(route: route, completion: completion)
    }
}
