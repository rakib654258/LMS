//
//  LoginViewModel.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 20/1/25.
//

import Foundation
import LocalAuthentication

class LoginViewModel {
    
    enum BiometricAuthResult {
        case success
        case failure(String)
        case unavailable(String)
    }
    
    // Check the available biometric type
    func getBiometricType() -> LABiometryType {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            return context.biometryType // Face ID, Touch ID, or None
        } else {
            return .none
        }
    }
    
    // Perform biometric authentication
    func authenticateUser(completion: @escaping (BiometricAuthResult) -> Void) {
        let context = LAContext()
        let reason = "Authenticate to access your account."
        
        // Check if biometrics are available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        completion(.success)
                    } else {
                        let errorMessage = error?.localizedDescription ?? "Authentication failed."
                        completion(.failure(errorMessage))
                    }
                }
            }
        } else {
            let errorMessage = "Biometric authentication is not available on this device."
            completion(.unavailable(errorMessage))
        }
    }
}
