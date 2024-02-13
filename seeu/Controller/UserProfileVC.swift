//
//  UserProfileVC.swift
//  seeu
//
//  Created by 김범석 on 2024/01/22.
//

import UIKit
import Firebase


private let reuseIdentifier = "Cell"
private let headerIdentifier = "UserProfileHeader"

class UserProfileVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - 속성표시
    
    var user: User?
    var posts = [Post]() // 현재 포스트라는 변수를 생성한 이유는 빈 배열을 작성하여 우리가 값들을 저장하기 위한거라고 생각하면 됨

    
    override func viewDidLoad() {
        super.viewDidLoad()

        

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)//사용자 헤더 등록하였으며
        
        
        // 배경 색
        self.collectionView.backgroundColor = .white
        
        // 사용자 데이터 가져와서 이제 비교함
        fetchCurrentUserData()
        
        fetchPosts()
    }

    

    // MARK: UICollectionView

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //여기서 위에서 등록한 header를 선언하여
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! UserProfileHeader
        
        
        
        
        
        // set the user in header
        header.user = self.user
        //navigationItem.title = user?.name
        self.navigationController?.navigationBar.topItem?.title = "프로필"
        //header.delegate = self
        
        
        // 헤더 리턴
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 400) // 여기 원래 200
    }

    // MARK: - database를 통한 API로 내 아이디 불러오기, 불러오고 게시글의 내용을 가져와서 적용하기 
    
    // 로그인 한 계정에 맞춰서 , 저장된 게시물들의 값들을 가져오는 단계 ,  그 값들을 출력, 하위 데이터를 포함하여 해당 위치의 모든 데이터를 포함하는 snapshot이 이벤트 콜벡에 전달됩니다.
    func fetchPosts() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        USER_POSTS_REF.child(currentUid).observe(.childAdded) { snapshot in // 현재 로그인된 계정에서 게시물들의 정보들을 가져온거임 ! 그래서 우리가 snapshot을 출력해봤을때 게시물들의 대빵의 정보들을 출력할 수 있었던것이였고 ! 그걸이용해서 잉제 게시물들의 정보들이 나올 수 있게 만들어야지!
            
            let postId = snapshot.key
            
            POSTS_REF.child(postId).observeSingleEvent(of: .value) { snapshot in
                guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
                
                let post = Post(postId: postId, dictionary: dictionary)
                
                self.posts.append(post)  // 이런식으로 코드를 짜는 이유는 위에 스냅샷을 통해 , 게시글의 키와 벨류를 얻을 수 있었음 , 그래서 이제 키와 벨류를 따로 values를 이용해서 값을 뽑아내면 내가 원하는 아이디에 맞춰서 값들이 나오게 되니깐 ! 딕셔너리 형태로 값을 저장해두고 , 우리가 post라는 파일에서 적은거처럼 포스트 생성자를 통해서 아이디를 통해서 값이 나오는걸 post로 넣고 ! / 그 다음에 posts라고 변수를 만들어서 (저장할 수 있는 딕셔너리 형태로 만들어줘서 ) 거기에 추가를 시켜놓는거임 !
                
                
            }
            
        }
        
    }
    
    
    func fetchCurrentUserData() {
        
        
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("user").child(currentUid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            self.user = user
            self.navigationItem.title = user.name
            
            
            
            self.collectionView?.reloadData()
            
            
            
            
            
            
            
            
            
            //삭제됨 guard let username = snapshot.value as? String else { return }
            
            //self.navigationController?.title = username (원래 이건데 , 곂치기 때문에 프로필로 설정함)
            
            // 삭제됨 _ = username
            
            //self.navigationController?.navigationBar.topItem?.title = username
            //self.navigationController?.navigationBar.topItem?.title = "프로필"
            //UIFont.systemFont(ofSize: 30)
            
            //var attributes = [ NSAttributedString.Key.foregroundColorNSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "the font name", size: 18)! ]

            
            
        }
        
        
    }
    

    
    

}
