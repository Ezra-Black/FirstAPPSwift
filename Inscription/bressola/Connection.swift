//
//  Connection.swift
//  bressola
//
//  Created by Morgann Riu on 23/10/2019.
//  Copyright © 2019 Morgann Riu. All rights reserved.
// récupere le pseudo et le mail de l'utilisateur

import UIKit
class User{
    
    static let shared = User()
    
    var pseudo: String = ""
    var mail: String = ""
    
    
    func LogoutUser() {
          User.shared.pseudo = ""
         User.shared.mail = ""
    }
    
}
