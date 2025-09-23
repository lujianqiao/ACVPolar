//
//  ACVEditUserInfoVC.swift
//  ACVPolar
//  
//  Created by _.
//  Copyright © 2025/8/7 _. All rights reserved.
//

import UIKit
import TZImagePickerController

class ACVEditUserInfoVC: ACVBaseViewController {

    private var avatarIamge: UIImage?
    
    lazy var bgImageView: UIImageView = {
        let image: UIImageView = .init()
        image.image = UIImage(named: "SI_login_bg")
        return image
    }()
    
    lazy var titleImageView: UIImageView = {
        let image: UIImageView = .init()
        image.image = UIImage(named: "SI_userinfo_UI_title")
        return image
    }()
    
    lazy var contentBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    
    lazy var avatarLabel: UILabel = {
        let lab: UILabel = .init()
        lab.text = "Avatar"
        lab.textColor = .black
        lab.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return lab
    }()
    
    lazy var avatarBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setImage(UIImage(named: "SI_userinfo_UI_photo"), for: .normal)
        btn.backgroundColor = .init(hex: "#F1F1F1")
        btn.layer.cornerRadius = 54
        btn.layer.masksToBounds = true
        btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            guard let picker = TZImagePickerController.init(maxImagesCount: 1, delegate: self) else {return}
            picker.preferredLanguage = "en"
            picker.allowTakeVideo = false
            present(picker, animated: true)
        }).disposed(by: rx.disposeBag)
        return btn
    }()
    
    lazy var nameLabel: UILabel = {
        let lab: UILabel = .init()
        lab.text = "Nickname"
        lab.textColor = .black
        lab.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return lab
    }()
    
    lazy var nameTextField: UITextField = {
        let field: UITextField = .init()
        field.placeholder = "Nickname"
        field.font = UIFont.systemFont(ofSize: 16)
        field.textColor = .black
        field.backgroundColor = .init(hex: "#E8E7E7")
        field.layer.cornerRadius = 14
        
        let leftView = UIView(frame: .init(x: 0, y: 0, width: 22, height: 22))
        field.leftView = leftView
        field.leftViewMode = .always
        
        return field
    }()
    
    lazy var ageLabel: UILabel = {
        let lab: UILabel = .init()
        lab.text = "Age"
        lab.textColor = .black
        lab.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return lab
    }()
    
    lazy var ageTextField: UITextField = {
        let field: UITextField = .init()
        field.placeholder = "Age"
        field.font = UIFont.systemFont(ofSize: 16)
        field.textColor = .black
        field.backgroundColor = .init(hex: "#E8E7E7")
        field.layer.cornerRadius = 14
        
        let leftView = UIView(frame: .init(x: 0, y: 0, width: 22, height: 22))
        field.leftView = leftView
        field.leftViewMode = .always
        
        return field
    }()
    
    lazy var nextBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        btn.layer.cornerRadius = 14
        btn.backgroundColor = .init(hex: "#79DC42")
        btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            let vc = ACVEditUserInfoVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: rx.disposeBag)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }

}

extension ACVEditUserInfoVC {
    func setUI() {
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { make in
            make.left.equalTo(35)
            make.top.equalTo(25 + kNavHeight)
            make.size.equalTo(CGSize(width: 266, height: 24))
        }
        
        view.addSubview(contentBGView)
        contentBGView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(titleImageView.snp.bottom).offset(41)
            make.height.equalTo(393)
        }
        
        contentBGView.addSubview(avatarLabel)
        avatarLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(45)
        }
        
        contentBGView.addSubview(avatarBtn)
        avatarBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatarLabel.snp.bottom)
            make.width.height.equalTo(108)
        }
        
        contentBGView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(avatarBtn.snp.bottom).offset(15)
        }
        
        contentBGView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(18)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.height.equalTo(58)
        }
        
        contentBGView.addSubview(ageLabel)
        ageLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(nameTextField.snp.bottom).offset(15)
        }
        
        contentBGView.addSubview(ageTextField)
        ageTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(18)
            make.top.equalTo(ageLabel.snp.bottom).offset(10)
            make.height.equalTo(58)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(35)
            make.top.equalTo(contentBGView.snp.bottom).offset(60)
            make.height.equalTo(58)
        }
    }
}

extension ACVEditUserInfoVC: TZImagePickerControllerDelegate {
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
        guard let image = photos.first else { return }
        avatarBtn.setImage(image, for: .normal)
        avatarIamge = image
    }
}
