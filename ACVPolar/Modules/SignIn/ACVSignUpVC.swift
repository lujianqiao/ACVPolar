//
//  ACVSignUpVC.swift
//  ACVPolar
//  
//  Created by _.
//  Copyright © 2025/9/23 _. All rights reserved.
//

import UIKit
import RZColorfulSwift
import RxSwift

class ACVSignUpVC: ACVBaseViewController {

    /// 是否同意隐私政策
    private var isAgree: Bool = false
    
    lazy var bgImageView: UIImageView = {
        let image: UIImageView = .init()
        image.image = UIImage(named: "SI_BG")
        return image
    }()
    
    lazy var titleImageView: UIImageView = {
        let image: UIImageView = .init()
        image.image = UIImage(named: "SI_sign_up_title")
        return image
    }()
    
    lazy var accountVGView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    
    lazy var notHaveAccountLab: UILabel = {
        let lab: UILabel = .init()
        lab.rz.colorfulConfer { confer in
            confer.text("Dont’t have an account?")?.textColor(.init(hex: "#9B9A9E")).font(.systemFont(ofSize: 14))
            confer.text(" Sign in")?.textColor(.init(hex: "#8FD61B")).font(.systemFont(ofSize: 14, weight: .bold)).tapActionByLable("notHaveAccountLab")
        }
        lab.rz.tapAction {[weak self] label, tapActionId, range in
            guard let self = self else { return }
            let vc = ACVSignInVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return lab
    }()
    
    lazy var accountTextField: UITextField = {
        let field: UITextField = .init()
        field.placeholder = "Email"
        field.font = UIFont.systemFont(ofSize: 16)
        field.textColor = .black
        field.backgroundColor = .init(hex: "#E8E7E7")
        field.layer.cornerRadius = 14
        
        let leftView = UIView(frame: .init(x: 0, y: 0, width: 22, height: 22))
        field.leftView = leftView
        field.leftViewMode = .always
        
        return field
    }()
    
    lazy var pwTextField: UITextField = {
        let field: UITextField = .init()
        field.placeholder = "Password"
        field.font = UIFont.systemFont(ofSize: 16)
        field.textColor = .black
        field.backgroundColor = .init(hex: "#E8E7E7")
        field.layer.cornerRadius = 14
        field.isSecureTextEntry = true
        
        let leftView = UIView(frame: .init(x: 0, y: 0, width: 22, height: 22))
        field.leftView = leftView
        field.leftViewMode = .always
        
        return field
    }()
    
    lazy var signInBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        btn.layer.cornerRadius = 14
        btn.backgroundColor = .init(hex: "#3B3B3B")
        btn.isEnabled = false
        btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            let vc = ACVGenderVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: rx.disposeBag)
        return btn
    }()
    
    /// 隐私、用户协议
    private lazy var protocolBtn: ACVButton = {
        let btn = ACVButton()
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.titleLabel?.numberOfLines = 0
        btn.setTitleColor(.init(hex: "#8C8C8C"), for: .normal)
        btn.spacingBetweenImageAndTitle = 5
        btn.titleLabel?.rz.tapAction({ [weak self, weak btn] _, tapActionId, _ in
            guard let btn = btn else { return }
            guard let self = self else { return }
            self.view.endEditing(true)
            if tapActionId == "user" {
//                let web = ADSUserAgreementViewController()
//                self.navigationController?.pushViewController(web, animated: true)
            } else if tapActionId == "privacy" {
//                let web = ADSPrivacyPolicyViewController()
//                self.navigationController?.pushViewController(web, animated: true)
            } else if tapActionId == "agree"  {
                self.isAgree.toggle()
                btn.rz.colorfulConfer(confer: { confer in
                    Self.updateProtocolBtnContent(confer, isAgree: self.isAgree)
                }, for: .normal)
            }
        })
        btn.rz.colorfulConfer(confer: { confer in
            Self.updateProtocolBtnContent(confer, isAgree: self.isAgree)
        }, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI() {
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { make in
            make.left.equalTo(35)
            make.top.equalTo(kNavHeight + 11)
            make.size.equalTo(CGSize(width: 172, height: 58))
        }
        
        view.addSubview(accountVGView)
        accountVGView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(titleImageView.snp.bottom).offset(22)
            make.height.equalTo(228)
        }
        
        accountVGView.addSubview(notHaveAccountLab)
        notHaveAccountLab.snp.makeConstraints { make in
            make.left.equalTo(59)
            make.top.equalTo(17)
        }
        
        accountVGView.addSubview(accountTextField)
        accountTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(notHaveAccountLab.snp.bottom).offset(28)
            make.height.equalTo(58)
        }
        
        accountVGView.addSubview(pwTextField)
        pwTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(accountTextField.snp.bottom).offset(20)
            make.height.equalTo(58)
        }
        
        view.addSubview(signInBtn)
        signInBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(35)
            make.top.equalTo(accountVGView.snp.bottom).offset(60)
            make.height.equalTo(58)
        }
        
        view.addSubview(protocolBtn)
        protocolBtn.snp.makeConstraints { make in
            make.top.equalTo(signInBtn.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        let emailValid = accountTextField.rx.text.orEmpty.map({$0.count > 0})
        let pasd = pwTextField.rx.text.orEmpty.map({$0.count > 0})
        let allValid = Observable.combineLatest(emailValid, pasd) { $0 && $1 }.share(replay: 1)
        
        allValid.subscribe(onNext: {[weak self] allInPut in
            guard let self = self else { return }
            if allInPut {
                self.signInBtn.isEnabled = true
                self.signInBtn.backgroundColor = .init(hex: "#79DC42")
            } else {
                self.signInBtn.isEnabled = false
                self.signInBtn.backgroundColor = .init(hex: "#3B3B3B")
            }
            
        }).disposed(by: rx.disposeBag)
    }

    /// 刷新隐私政策按钮
    public static func updateProtocolBtnContent(_ confer: ColorfulConferrerRZ, isAgree: Bool) {
        var image: UIImage? = UIImage(named: "login_protocol_normal")
        if isAgree {
            image = UIImage(named: "login_protocol_select")
        }
        confer.paragraphStyle?.lineSpacing(2)
        confer.image(image)?
            .bounds(.init(x: 0, y: -6, width: 24, height: 24))
            .tapActionByLable("agree")
        confer.text("I have read and agree")
        confer.text("《User Service Agreement》")?.textColor(.init(hex: "#FF2C2C")).tapActionByLable("user")
        confer.text("And")
        confer.text("《Privacy Policy》")?.textColor(.init(hex: "#FF2C2C")).tapActionByLable("privacy")
    }
    
}
