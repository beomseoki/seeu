//
//  UserProfileHeader.swift
//  seeu
//
//  Created by 김범석 on 2024/01/25.
//

import UIKit

class UserProfileHeader: UICollectionViewCell {
    
    var user: User? {
        
        didSet {
            
            let fullName = user?.name
            nameLabel.text = fullName
            
            guard let profileImageUrl = user?.profileImageUrl else { return }
            
            profileImageView.loadImage(with: profileImageUrl)
            print("이미지 로드 성공했다")
            
        }
    }
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        
        
        return iv
        
        
        
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        //label.text = "Heath Ledger"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
//    let editProfileButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("프로필 편집", for: .normal)
//        button.layer.cornerRadius = 5
//        button.layer.borderColor = UIColor.lightGray.cgColor
//        button.layer.borderWidth = 0.5
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
//        return button
//    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("프로필 편집", for: .normal)
        button.backgroundColor = UIColor(red: 98/255, green: 206/255, blue: 203/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 13
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 5
        return button
    }()
    
    
    
    override init(frame: CGRect) { // 여기는 viewdidload랑 같은곳
        super.init(frame: frame)
        
        //self.backgroundColor = .red //배경색을 통해서 header에 있는 사이즈를 확인해볼 수 있음
        
        
        addSubview(profileImageView)
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 105, paddingBottom: 0, paddingRight: 12, width: 200, height: 200)
        profileImageView.layer.cornerRadius = 200 / 2 // 너비와 높이의 값의 따라서 나누게 되면 동그라미가 제대로 됨 (너비 높이 80으로 했고 그거에따라서 갚을 동일하게 해서 동그라미를 만들었음) 105 레프트 , 너비 ㄴ
        
//        addSubview(usernameLabel)
//        usernameLabel.anchor(top: profileImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 14, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 14, paddingBottom: 0, paddingRight: 14, width: 0, height: 0)
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top: nameLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 60, paddingLeft: 14, paddingBottom: 0, paddingRight: 14, width: 0, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
