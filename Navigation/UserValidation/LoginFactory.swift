//
//  LoginFactory.swift
//  Navigation
//
//  Created by Vadim on 10.07.2022.
//

import Foundation

class MyLoginFactory: LoginFactory {
    
    static let shared = MyLoginFactory()
    
    func returnLoginInspector() -> LoginViewControllerDelegate {
         let inspector = LoginInspector()
         return inspector
     }
}

