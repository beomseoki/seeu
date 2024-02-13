//
//  LoginVCViewController.swift
//  Watch
//
//  Created by 김범석 on 2024/01/14.
//

import UIKit
import Firebase



    
class LoginVC: UIViewController {
    
    
    
//    // 이거는 유데미에 대한 내용을 넣은건데 , uiimageview에서 적용이 안됨 ;
//    let logoContainerView: UIView = {
//        let view = UIView()
//
//        let logoImageView = UIImageView(image: instr)
//        logoImageView.contentMode = .scaleAspectFill
//        view.addSubview(logoImageView)
//        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
//        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//
//        return view
//    }()
    
    let logoContainerView: UIView = {
        let view = UIView()
        //let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white")) //여기에 이미지 넣어서 이쁘게 가능 #imageliteral()을 이용하면 됨
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "coconut . (2)"))
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //view.backgroundColor = UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1)
        view.backgroundColor = UIColor(red: 98/255, green: 206/255, blue: 203/255, alpha: 1)
        return view
    }()
    
    
    
    
    
//    let emailTextField: UITextField = {
//        let tf = UITextField()
//        tf.placeholder = "Email"
//        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
//        tf.borderStyle = .roundedRect
//        tf.font = UIFont.systemFont(ofSize: 14)
//        tf.addTarget(self, action: #selector(forValidation), for: .editingChanged)
//        return tf
//    }()
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "이메일"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        //tf.frame.size.height = 48
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(forValidation), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        //tf.frame.size.height = 48
        tf.layer.cornerRadius = 10
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(forValidation), for: .editingChanged)
        return tf
    }()
    
//    let loginButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Login", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
//        button.isEnabled = false // 처음부터 적용안된다고 먼저 말해놔야지
//        button.layer.cornerRadius = 5
//        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
//        return button
//    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        //button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.backgroundColor = UIColor(red: 130/255, green: 210/255, blue: 205/255, alpha: 1)
        button.isEnabled = false // 처음부터 적용안된다고 먼저 말해놔야지
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "계정을 가지고 있지 않으신가요?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "회원가입", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor:  UIColor(red: 0/255, green: 0/223, blue: 0/255, alpha: 1)]))
        //UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        //사이즈 14
        
        
        return button
    }()
    
//    let AccoutButton: UIButton = {
//        let button = UIButton(type: .system)
//
//        button.setTitle("회원가입", for: .normal)
//
//
//
//
//    }()
    
    
    
    // MARK: - 이메일, 이미지 추가할것들 적어놈
    

    
//    let titleImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(named: "learning.png")
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1)
//
//        return imageView
//
//
//    }()
    
//    let descriptionLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
//        label.textColor = .black
//        label.textAlignment = .center
//        label.text = "강의 정보를 더 편하고 쉽게"
//        label.numberOfLines = 1
//        return label
//    }()
//
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
//        label.textColor = UIColor(r: 198, g: 41, b: 23)
//        label.textAlignment = .center
//        label.text = "강의뭐봐"
//        label.numberOfLines = 1
//        return label
//    }()
//
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //background color
        view.backgroundColor = .white
        
//        view.addSubview(titleImageView)
//
//        NSLayoutConstraint.activate([
//            titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            titleImageView.widthAnchor.constraint(equalToConstant: 150),
//            titleImageView.heightAnchor.constraint(equalToConstant: 200),
        //]) //image 조절하는 제약
        
        // 내비게이션 위에 막대 없애기
        
        navigationController?.navigationBar.isHidden = true
        
        navigationController?.navigationBar.barStyle = .black
        
        


        
        
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 140)
        
        configureViewComponents()
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 480, paddingRight: 0, width: 0, height: 50) // 50

        
        
        
        
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        navigationController?.title = "행복"
//    }
//
    // MARK: - 로그인 쪽
    

    @objc func handleShowSignUp() {
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
        //print("회웍나입")
//        let naVC = UINavigationController(rootViewController: signUpVC)
//        naVC.modalPresentationStyle = .fullScreen
        //self.present(signUpVC, animated: true, completion: nil)
        
    }
    
    @objc func handleLogin() {
        
        // 로그인 하기위한 이메일,비밀번호를 가져와야함 ! 로그인 버튼 눌러서 이제 데베에 있는 정보랑 비교를 해야하니깐
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        
        
        // 이메일과 이제 비번을 가져와서 서명할 수 있게 !
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            
            
            // 가져오는데 에러가 뜨는경우
            if let error = error {
                print("해당 계정에 로그인 할 수 없습니다." , error.localizedDescription)
                return
            }
            
            // 이메일 , 비번을 가져오는데 성공한 경우
            print("성공적으로 로그인 됨 ")
            
            // MARK: - 2
            

            
            //let win = self.view.window?.rootViewController as? MainTabVC
            //guard let mainTabVC = win else { return }
            
//            let win = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//            guard let mainTabVC = win?.rootViewController as? MainTabVC else { return }
            //guard let mainTabVC = UIApplication.shared.keyWindow?.rootViewController as? MainTabVC else { return }
            
            //*guard let mainTabVC = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? MainTabVC else { return }
            
            
            
            
            // 그래서 이제 우리는 maintabVC에 성공적으로 키보드가 나올 수 있도록? 했으면 보여주는거임
            //*mainTabVC.configureViewControllers()
            
            //self.navigationController?.pushViewController(mainTabVC, animated: true)
            
            // 로그인 컨트롤러 사라지게
            //*self.dismiss(animated: true, completion: nil)
            
            
            
            
            
            
//            // 겹치게 되면 이 코드는 다음 창을 보여줌 / 이렇게 하면 우리가 로그아웃하고 , 다시 로그인하면 계속해서 그 상황이 겹쳐져서 느려지게 되는거임
            let mainTabVC = MainTabVC()
            self.navigationController?.pushViewController(mainTabVC, animated: true)
            mainTabVC.modalPresentationStyle = .fullScreen
        
            
            
            
        }
        
        
        
    }
    
    @objc func forValidation() {
        
        // 로그인 하기위해서 이메일, 비밀번호가 텍스트필드에 잘 적혀져있는걸 확인하는거 hastext
        guard
            emailTextField.hasText,
            passwordTextField.hasText else {
                
                // 근데 비어있음, 즉 사용자가 아이디 비번 안적었다는거임
                loginButton.isEnabled = false
                //*loginButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
                loginButton.backgroundColor = UIColor(red: 130/255, green: 210/255, blue: 205/255, alpha: 1)
                //loginButton.backgroundColor = UIColor.systemBlue
                //rgb(135,210,223)
                return
                
                
        }
        
        // 근데 비어있지않고 제대로 작성이 되었다면 !
        
        loginButton.isEnabled = true
        //*loginButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        loginButton.backgroundColor = UIColor(red: 135/255, green: 200/223, blue: 223/255, alpha: 1)
        //loginButton.backgroundColor = UIColor.systemGray4
        //rgb(121,206,219)
        
    }
    
    
    func configureViewComponents() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 10
        //stackView.frame.size.height = 48
        //stackView.alignment = .fill
        
        
        
        view.addSubview(stackView)
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 45, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 180) // 140
        
        
//        view.addSubview(descriptionLabel)     설명창 넣어보는거
//        descriptionLabel.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 1000)
        
        
        
        
        
        
        
        
    }
    

    

}

