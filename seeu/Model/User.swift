//
//  User.swift
//  seeu
//
//  Created by 김범석 on 2024/01/25.
//

import Foundation

class User {
    
    //유저의 내용들 , 주석은 내가 없는것
    //var username: String!
    var name: String!
    var profileImageUrl: String!
    var uid: String!
    
    init(uid: String, dictionary: Dictionary<String, AnyObject>) { //uid를 통해서 키와 벨류값을 찾는 개념
        
        self.uid = uid
        
//        if let username = dictionary["username"] as? String {
//            self.username = username
//        }
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let profileImageUrl = dictionary["profileImageUrl"] as? String {
            self.profileImageUrl = profileImageUrl
        }
        
    }
    
    
    
}
