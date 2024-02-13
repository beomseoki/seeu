//
//  Constants.swift
//  seeu
//
//  Created by 김범석 on 2024/01/30.
//

import Firebase

let DB_REF = Database.database().reference()

let USER_REF = DB_REF.child("user") //users

let POSTS_REF = DB_REF.child("post") //posts


let USER_POSTS_REF = DB_REF.child("user-posts") // 게시하기 위한 내용들을 적어놓은 창들  
