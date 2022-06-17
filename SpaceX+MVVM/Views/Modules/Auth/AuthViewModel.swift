//
//  AuthViewModel.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 17.06.2022.
//

import Foundation

class AuthViewModel {
    
    var isLoggedIn = false
    
    func loginButtonPressed(email: String, password: String) {
        if email != User.data[0].email || password != User.data[0].password {
            isLoggedIn = false
        }
        else {
            isLoggedIn = true
        }
    }
}
