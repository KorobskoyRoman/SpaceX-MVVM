//
//  UserModel.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 17.06.2022.
//

import Foundation

struct UserData: Codable {
    let firstName: String?
    let secondName: String?
    let phone: String?
    let age: String?
}

struct User: Codable {
    let email: String?
    let password: String?
}

extension User {
    static var data = [User(email: "123", password: "123")]
}

extension UserData {
    static let userInfo = UserData(firstName: "Roman", secondName: "Korobskoy", phone: "+7(918)111-11-11", age: "25")
}
