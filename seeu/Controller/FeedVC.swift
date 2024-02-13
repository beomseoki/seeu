//
//  FeedVC.swift
//  seeu
//
//  Created by 김범석 on 2024/01/22.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedVC: UICollectionViewController {
    
    // MARK: - 속성을 선언하기?
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // 로그아웃 버튼 함수
        configureLogoutButton()
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        return cell
    }
    
    // MARK: - 기능 탐색, 구성 / 로그인 기능 탐색하고 로그아웃하려고
    
    func configureLogoutButton() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout)) // 로그아웃 버튼을 눌렀을때 이제 액션에 있는 핸들에 대한 오브젝트쪽함수가 실행
        
    }
    
    //
    

    
    @objc func handleLogout() {
        
        // 로그아웃 할때 상태창 같은거
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 로그아웃 상태창을 이제 행동으로 더해서 보여주는거임 위에는 컨트롤러로 움직여주기때문에 여기에 addaction을 통해 더해줘야지
        alertController.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (_) in
            
            do {
                
                //이제 로그인 상태에 대해서 로그아웃을 하는거기때문에 throws를 사용하고 그래서 do,catch문을 사용한듯 , 그리고 로그인 , 로그아웃에 대한 내용이 들어가기때문에 3가지의 문장을 사용하는듯
                try Auth.auth().signOut()  // 로그아웃 하는 문장
                
                // 현재 로그인 정보가 있음을 알려주는 로그와 컨트롤러 제시
                
                let loginVC = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC) // 로그인 네비게이션으로 변경해주는거임,  그리고 이렇게 해줬으니깐 로그인 화면이랑 연결돼어서 안되면 일로 다시 넘어가는거임
                // 그 다음에 네비게이션으로 변경 해줬으니깐 이제 보내줘야지
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
                
                
                //*self.navigationController?.pushViewController(navController, animated: true)
            
                print("로그아웃 성공")
                
                
            } catch {
                
                // 만약 에러가 떳을때 (로그아웃이 안돼서)
                print("로그아웃 실패")
                
            }
            
        }))
        
        // 취소 옵션을 추가해주기 (즉 로그아웃 할거냐?, 아니면 잘못눌렀으니 취소 ? 이렇게) , 위에는 로그아웃에 대한 내용, 이거는 취소에 대한 내용
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //다시 화면에 돌아오는거 같은데 , alertController는 잘 모르겠네
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    
    

}
