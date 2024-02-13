//
//  Extensions.swift
//  seeu
//
//  Created by 김범석 on 2024/01/18.
//

import UIKit


extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
            
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        
        }
        
    }
}

var imageCache = [String: UIImage]()

extension UIImageView {
    
    func loadImage(with urlString: String) {
        
        // 이미지가 캐쉬데이터로 존재하는지 확인하고 싶음, cache 키값을 넣어서 이제 벨류로 나오게 하는거임
        if let cacheImage = imageCache[urlString] {
            self.image = cacheImage
            return
        }
        
        // 저는 
        
        // 이미지 위치
        guard let url = URL(string: urlString) else { return }
        
        // url콘텐츠를 가져오기 , HTTP의 각종 메서드를 이용해 서버로부터 응답 데이터를 받아서 Data 객체를 가져오는 작업을 수행합니다.
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            //에러가 뜬 경우
            if let error = error {
                print("이미지를 불러오지 못해서 에러", error.localizedDescription)
            }
            
            // 이미지 데이터를 만든경우
            guard let imageData = data else { return }
            
            // 가져온 이미지를 통해 이미지 설정
            let photoImage = UIImage(data: imageData)
            
            // 키 값이랑 이미지 캐시를 설정 , 키값은 이미지의 문자열 , 벨류는 당연히 이미지 사진이됨
            imageCache[url.absoluteString] = photoImage
            
            // 이미지 설정
            DispatchQueue.main.async {
                self.image = photoImage
            }
            
            
        }.resume() //일시중단된 작업을 재개해서 중단되면 다시 이미지가 로드될 수 있도록
        
    }
}
