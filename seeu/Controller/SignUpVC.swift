//
//  SignUpVC.swift
//  Watch
//
//  Created by 김범석 on 2024/01/16.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageSelected = false
    
    
    

    
    
    let plusPhotoBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSelectProFilePhoto), for: .touchUpInside)
        
        return button
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "이름"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(forValidation), for: .editingChanged)
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "아이디"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(forValidation), for: .editingChanged)
        return tf
    }()
    
    let passWordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(forValidation), for: .editingChanged)
        
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    let alreadyAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "계정을 가지고 있나요?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "로그인", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)]))
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        
        
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //backgroud Color
        view.backgroundColor = .white
        
        
        view.addSubview(plusPhotoBtn)
        plusPhotoBtn.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 35, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140) // 0, , 150 , 250
        plusPhotoBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        configureViewComponents()
        
        view.addSubview(alreadyAccountButton)
        alreadyAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 330, paddingRight: 0, width: 0, height: 200) // paddingbottom 0
        
        
    }
    
    
    //이거는 이제 우리가 위에 imagePicker를 이제 상속을 받았기때문에 쓸 수 있는 함수 !, 그리고 내가 이제 선택을 하면 그 선택된 이미지가 불러온다는 함수라는 뜻임
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 이미지 선택
        guard let profileImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            imageSelected = false // 위에서 만든 이미지 변수는 기본값이 false이고 지금 선택되지 않았으니깐
            return
        }
        
        imageSelected = true // 그러면 선택이 되면 이제 imageseleteced를 true로 바꾸면 되겠지
        
        // 이미지를 선택하면 그 이미지에 맞게 설정될 수 있게
        plusPhotoBtn.layer.cornerRadius = plusPhotoBtn.frame.width / 2
        plusPhotoBtn.layer.masksToBounds = true
        plusPhotoBtn.layer.borderColor = UIColor.black.cgColor
        plusPhotoBtn.layer.borderWidth = 2
        plusPhotoBtn.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        
        self.dismiss(animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    
    
    @objc func handleShowLogin() {
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passWordTextField.text else { return }
        guard let name = nameTextField.text else { return }
        
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            
            // 사용자의 대한 에러가 뜰경우
            if let error = error {
                print("아이디가 생성되지 않았습니다, ", error.localizedDescription)
                return
            }
            
            // 이미지 선택을 한 경우 !
            guard let profileImage = self.plusPhotoBtn.imageView?.image else { return }
            
            // 이미지를 선택한 후 그 이미지 데이터를 업로드하는거 !
            guard let uploagdData = profileImage.jpegData(compressionQuality: 0.3) else { return }
            
            // 그 다음에 데이터로 변경을 했음 우리는! 그리고 그 데이터를 이제 우린 저장소(데이터베이스)에 넣을려고 하는거임
            let filename = NSUUID().uuidString // 이거는 그냥 쉽게 고유번호 키라고 생각하삼 , 중요 x.
            
            
            let storageRef = Storage.storage().reference().child("profile_images").child(filename)
                
                
                
                _ = storageRef.putData(uploagdData, metadata: nil) { matadata, error in
                
                
                //데이터를 넣을때 오류 확인하기위함 ! 위에 error있는걸 쓰는거임
                
                if let error = error {
                    print("Failed to upload", error.localizedDescription)
                    return
                }
                
                
                
                // 프로필 이미지 만드는쪽이고 이 밑에 코드는 내 사진이나, 사진을 찾을 수 있는 URL을 만드는거임
                    storageRef.downloadURL { (downloadURL,error) in
                        guard let profileImageURL = downloadURL?.absoluteString else { return }
                        
                        let dictionaryValue = ["name": name, "profileImageUrl": profileImageURL]
                        
                        // 유저 아이디
                        
                        guard let uid = user?.user.uid else { return }
                        
                        let values = [uid: dictionaryValue]
                        
                       
                        
                        // 사용자 정보를 데이터 베이스에 저장하기
                        Database.database().reference().child("user").updateChildValues(values) { error, ref in
                            print("성공적으로 데이터베이스에 저장됐다.")
                        }

                    }
                    
                    
                    
                    
            }
                    
            
            
            
        }
        
        
    }
    
    // MARK: - 로그인버튼 색깔 변경
    

    
    @objc func forValidation() {
        
        guard
            emailTextField.hasText, //두개의 대한 텍스트가 없을때 else문 실행 /이거는 쉽게 텍스트가 채워질때를 확인하기 위한 함수
            passWordTextField.hasText,
            nameTextField.hasText,
            imageSelected == true else { // 만약 이미지를 안넣어도 되면 그냥 이 부분만 없애면 됨  
                loginButton.isEnabled = false
                loginButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
                return
            }
        
        loginButton.isEnabled = true  //위에 부분 즉 필드들이 다 채워졌을때는 이제 정상적인 색깔이 나옴
        loginButton.backgroundColor = UIColor(red: 135/255, green: 200/223, blue: 223/255, alpha: 1)
                                                      
        
    }
    
    @objc func handleSelectProFilePhoto() {
        
        // 이미지를 가져오기 위해서는 이렇게 delegate를 이용해서 넣어주면 됨
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // 위에서 가져온 이미지를 이제 넘겨주기위한 present함수!
        DispatchQueue.main.async {
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        
        
    }
    
    func configureViewComponents() {
        
        let stackView = UIStackView(arrangedSubviews: [nameTextField,emailTextField,passWordTextField,loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        
        
        view.addSubview(stackView)
        stackView.anchor(top: plusPhotoBtn.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 240) //24
    
    }
}
