//
//  Post.swift
//  seeu
//
//  Created by 김범석 on 2024/02/02.
//

import Foundation

class Post {
    
    var caption: String!
    var like: Int!
    var ownerUid: String!
    var creationDate: Date!
    var postId: String!
    
    // postId를 통해서 얻은 값들을 들어가보면 이제 키와 벨류 캡션,라이크 같은것들을 비교해서 값들을 뽑을 수 있는구조!
    init(postId: String!, dictionary: Dictionary<String, AnyObject>) {
        
        self.postId = postId
        
        if let caption = dictionary["caption"] as? String {
            self.caption = caption
        }
        
        if let like = dictionary["like"] as? Int {
            self.like = like
        }
        
        if let ownerUid = dictionary["ownerUid"] as? String {
            self.ownerUid = ownerUid
        }
        
        if let creationDate = dictionary["creationDate"] as? Double {
            self.creationDate = Date(timeIntervalSince1970: creationDate)
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
}
