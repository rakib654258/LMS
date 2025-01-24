//
//  Constants.swift
//  Created by Abdul Motalab Rakib on 23/9/24.
//

import Foundation
import UIKit

class AppConstants {
    struct Server {
        static let baseURL = "https://newstagingshopapi.lastmanstands.com/"
    }
    
    struct App {
        static var deviceType: Int { 2 }
        
        // MARK: - Build Version
        static var appVersionCode: String {
            return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "0"
        }
        
        // MARK: - Application Version
        static var appVersion: String {
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
        }
        
        static var deviceID: String {
            return UIDevice.current.identifierForVendor?.uuidString ?? "0"
        }
        
//        static var appSecretKey: String {
//            "04D820AF0F237607F17CEBBC6449006E51C87A49ABB348D3DDA52B7AB1A3304D"
//        }
//        
//        static var encryptedHeaderKey: String { "API-REQUEST-HEADER" }
//        static var encryptionSecretKey: String { "Nx123OTT0923J129" }
//        
//        static var appSecretKeyV2: String {
//            "05f67f8bee9525de6ce8439bf7367cdb5a6339bc79bb0a966cbebb8246b50134"
//        }
//        
//        static var encryptedHeaderKeyV2: String { "API-REQUEST-HEADER" }
//        static var encryptionSecretKeyV2: String { "T20TSportsANDNex" }
//        
//        static let googleClientID = "274725869110-52mmvsifv2rll870ccpshf2gejq8tc0s.apps.googleusercontent.com"
    }
    
    enum apiVersion: String {
        case v1
        case v2
    }
    
//    static var userAgent: String {
//        let appVersion = DeviceSettings.getAppVersion()
//        let iOSVersion = DeviceSettings.getiOSVersion()
//        let customerId = String(LoginDataManager.shared.subscriberID)
//        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? "0"
//
//        var userAgent = "TSports"
//        userAgent += "/\(appVersion) (BSD-Unix;iOS \(iOSVersion)) AVPlayerLib/12.4.0"
//        userAgent += "/\(customerId)/\(deviceId)"
//
//        return userAgent
//    }

}

enum NetworkContentType: String {
    case json = "application/json"
    case multipartFormData = "multipart/form-data"
    case formUrlencoded = "application/x-www-form-urlencoded"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case accessToken = "accesstoken"
    case userAgent = "User-Agent"
}

//enum UserDefaultKeys: String {
//    case hasLaunchedOnce = "HasLaunchedOnce"
//}

enum APIName: String {
    case registration = "registration"
    case otpVerification = "otp-verification"
    case login = "login"
    case applicationConfigurations = "application-configurations"
    case callLog = "call-log"
    case getMaskingNumber = "get-masking-numbers"
    case setMaskingNumbers = "set-masking-numbers"
    case subscriberProfile = "subscriber-profile"
    case setFcmToken = "set-fcm-token"
    case logout = "logout"
    case disableService = "disable-service"
}
