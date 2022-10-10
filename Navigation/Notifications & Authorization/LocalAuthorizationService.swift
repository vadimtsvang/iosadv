//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Vadim on 09.10.2022.
//

import LocalAuthentication
import UIKit

final class LocalAuthorizationService {
    
    static var shared = LocalAuthorizationService()
    
    // MARK: PROPERTIES
    
    private var context = LAContext()
    private let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
    private var error: NSError?
    private var canUserBiometrics = false
    
    public var availableAuthorizationType: LABiometryType
    
   private init() {
       self.canUserBiometrics = context.canEvaluatePolicy(policy, error: &self.error)
       self.availableAuthorizationType = context.biometryType
   }
    
    // MARK: METHODS
    
    public func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, Error?) -> Void) {
                
        guard canUserBiometrics else { return }
        
        context.evaluatePolicy(policy, localizedReason: "auth.getAuth".localized) { success, error in
                        
            DispatchQueue.main.async {
                if success { authorizationFinished(self.canUserBiometrics, error) }
            }
        }
    }
    
}
