//
//  ACVSignInViewController.swift
//  ACVPolar
//  
//  Created by _.
//  Copyright © 2025/8/7 _. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import NSObject_Rx

class ACVSignInViewController: ACVBaseViewController {

    lazy var bgImageView: UIImageView = {
        let image: UIImageView = .init()
        image.image = UIImage(named: "SI_BG")
        return image
    }()
    
    lazy var logoImageView: UIImageView = {
        let image: UIImageView = .init()
        image.image = UIImage(named: "SI_logo")
        return image
    }()
    
    lazy var titleImageView: UIImageView = {
        let image: UIImageView = .init()
        image.image = UIImage(named: "SI_title")
        return image
    }()
    
    lazy var loginBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setImage(UIImage(named: "SI_login_btn"), for: .normal)
        btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            let vc = ACVSignInVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: rx.disposeBag)
        return btn
    }()
    
    lazy var signUpBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setImage(UIImage(named: "SI_signUp_btn"), for: .normal)
        btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            let vc = ACVSignUpVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: rx.disposeBag)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }

    override var preferredNavigationBarHidden: Bool {true}
}

// MARK: action
extension ACVSignInViewController {
    func setUI() {
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(134)
            make.size.equalTo(CGSize(width: 87, height: 130))
        }
        
        view.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { make in
            make.left.equalTo(26)
            make.top.equalTo(logoImageView.snp.bottom).offset(54)
            make.size.equalTo(CGSize(width: 235, height: 60))
        }
        
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-57)
            make.width.equalTo(328.scale)
            make.height.equalTo(66.scale)
        }
        
        view.addSubview(signUpBtn)
        signUpBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginBtn.snp.top).offset(-20)
            make.width.equalTo(328.scale)
            make.height.equalTo(66.scale)
        }
    }
}
