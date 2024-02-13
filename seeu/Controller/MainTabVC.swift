//
//  MainTabVC.swift
//  seeu
//
//  Created by 김범석 on 2024/01/22.
//

import UIKit
import Firebase

class MainTabVC: UITabBarController, UITabBarControllerDelegate {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // delegate
        self.delegate = self
        
        //self.tabBarController?.delegate = self



        //밑에 이제 만들어놓은 탭바들을 불러오는 함수
        configureViewControllers()

        //* 사용자가 로그인을 했는지, 안했는지 확인하는 함수
        checkIfUserIsLoggedIn()
        
        
        
        


    }
    
    
    
    func configureViewControllers() {
        
        // home feed controller
        let feedVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // search feed controller
        //let searchVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchVC())
        
        // select image controller
//        let uploadPostVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: UploadPostVC())
        
        let uploadPostVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: UploadPostVC())
        
        
        // notification controller
        //let notificationVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationsVC())
        
        // profile controller
        let userProfileVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // view controllers to be added to tab controller
        //viewControllers = [feedVC, searchVC, selectImageVC, notificationVC, userProfileVC]
        //viewControllers = [feedVC, uploadPostVC, userProfileVC]
        viewControllers = [feedVC, uploadPostVC, userProfileVC]
        
        // tab bar tint color
        tabBar.tintColor = .black
    }
    
    
    

    // 탭바에 있는 함수들을 한곳에 저장해놓기
//    func configureViewcontroller() {
//
//        // 홈 피드 (현재 화면 -> 에브리타임 게시판 화면
//
//        let feedVC = constructNavController(unseletedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedVC(collectionViewLayout: UICollectionViewFlowLayout())) // 지금 보내는 쪽을 colletion이기 때문에 root로 이렇게 꼬아서 레이아웃을 넣어준거임
//
//
//        // 검색 피드 (게시판 다른 것들도 만들면 )
//        let searchVC = constructNavController(unseletedImage: #imageLiteral(resourceName: "search_unselected") , selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchVC())
//
//
//        // 업로드 컨트롤러 (글쓰기 쪽으로 넣어야겠다)
//
//        let uploadPostVC = constructNavController(unseletedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: UploadPostVC())
//
//        // 릴스 화면 (채팅)
//        let notificationVC = constructNavController(unseletedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationsVC())
//
//
//        // 프로필 화면 (프로필은 꼭 있어야함)
//
//        let userProfileVC = constructNavController(unseletedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())) // 띄움 띄움 간격을 주는 셀렉션이라고 생각하면됨
//
//        // 이제 아래에 네비게이션 탭바를 설정하기위해 리스트로 정렬시켜놓는거임
//        viewControllers = [feedVC, searchVC, uploadPostVC, notificationVC, userProfileVC]
//
//        // 탭바에 색깔을 지정해주는거
//
//        tabBar.tintColor = .black
//
//    }
    
    
    
    
    
    
    
    // 위에 네비게이션 화면 넘기는 거 같은데 , 이거는 이제 우리가 탭바를 선택할 때 그 선택된 이미지들을 갖게 해주는 함수
//    let image = UIImage()
    
    
    func constructNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        // construct nav controller
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.tintColor = .black
        
        // return nav controller
        return navController
    }
    
    
//    func constructNavController(unseletedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
//
//        // 이제 네비게이션컨트롤러를 이용해서 선택한거랑, 안한거에 대한 이미지를 넣어주는거임
//        let navController = UINavigationController(rootViewController: rootViewController)
//        navController.tabBarItem.image = unseletedImage
//        navController.tabBarItem.selectedImage = selectedImage
//        navController.navigationBar.tintColor = .black
////        navController.modalPresentationStyle = .fullScreen
//
//
//        // 네비게이션 컨트롤이 호출될때마다 위에 설정한대로 이미지로 반환되는거임
//        return navController
//
//    }
    
    
    
    
    
    // MARK: - 탭바 선택지
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = tabBarController.viewControllers?.firstIndex(of: viewController)
        
        if index == 1 {
            
//            let navigationController = UINavigationController()
//            let uploadPostVC = UploadPostVC()
//            navigationController.pushViewController(uploadPostVC, animated: true)
//            window?.rootViewController = navigationController
//            window?.makeKeyAndVisible()
            
            
            
            let uploadPostVC = UploadPostVC()
            let nav = UINavigationController(rootViewController: uploadPostVC)
            nav.navigationBar.tintColor = .black
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            
            
            
            
            return false
            
        }
        
        return true
    }
    

    
    
    
    
    
    // MARK: - 2
    

    //현재 사용자가 로그인이 되어있는지 확인하는 함수
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                // 현재 사용자가 없으니깐 빠르게 나가게 하는거임
                let loginVC = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC) // 로그인 네비게이션으로 변경해주는거임,  그리고 이렇게 해줬으니깐 로그인 화면이랑 연결돼어서 안되면 일로 다시 넘어가는거임
                // 그 다음에 네비게이션으로 변경 해줬으니깐 이제 보내줘야지
                
                navController.modalPresentationStyle = .fullScreen
                
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
    }
    
    
    
}
