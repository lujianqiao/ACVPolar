//
//  ACVGenderVC.swift
//  ACVPolar
//  
//  Created by _.
//  Copyright © 2025/9/23 _. All rights reserved.
//

import UIKit

enum ACVGenderType: Int {
    case famale = 1
    case male = 2
}

class ACVGenderVC: ACVBaseViewController {

    private var type: ACVGenderType = .famale
    
    lazy var bgImageView: UIImageView = {
        let image: UIImageView = .init()
        image.image = UIImage(named: "SI_BG")
        return image
    }()
    
    lazy var titleImageView: UIImageView = {
        let image: UIImageView = .init()
        image.image = UIImage(named: "SI_userinfo_gender_title")
        return image
    }()
    
    lazy var contentBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    
    lazy var womanBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setImage(UIImage(named: "SI_userinfo_gender_woman"), for: .normal)
        btn.setImage(UIImage(named: "SI_userinfo_gender_woman_select"), for: .selected)
        btn.isSelected = true
        return btn
    }()
    
    lazy var manBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setImage(UIImage(named: "SI_userinfo_gender_man"), for: .normal)
        btn.setImage(UIImage(named: "SI_userinfo_gender_man_select"), for: .selected)
        return btn
    }()
    
    lazy var chooseBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex: "#E8E8E8")
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var womanTitleBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setTitle("Famale", for: .normal)
        btn.setTitleColor(.init(hex: "#9B9A9E"), for: .normal)
        btn.setTitleColor(.init(hex: "#000000"), for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        btn.backgroundColor = .init(hex: "#79DC42")
        btn.isSelected = true
        btn.layer.cornerRadius = 18
        btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.chooseGender(type: .famale)
        }).disposed(by: rx.disposeBag)
        return btn
    }()
    
    lazy var manTitleBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setTitle("Male", for: .normal)
        btn.setTitleColor(.init(hex: "#9B9A9E"), for: .normal)
        btn.setTitleColor(.init(hex: "#000000"), for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        btn.backgroundColor = .init(hex: "#E8E8E8")
        btn.isSelected = false
        btn.layer.cornerRadius = 18
        btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.chooseGender(type: .male)
        }).disposed(by: rx.disposeBag)
        return btn
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
            let vc = ACVBodyPartVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: rx.disposeBag)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setaUI()
        // Do any additional setup after loading the view.
    }
    
    func setaUI() {
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { make in
            make.left.equalTo(35)
            make.top.equalTo(kNavHeight + 42)
            make.size.equalTo(CGSize(width: 246, height: 24))
        }
        
        view.addSubview(contentBGView)
        contentBGView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(titleImageView.snp.bottom).offset(25)
            make.height.equalTo(393)
        }
        
        contentBGView.addSubview(womanBtn)
        womanBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(63)
            make.size.equalTo(CGSize(width: 85, height: 290))
        }
        
        contentBGView.addSubview(manBtn)
        manBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalTo(63)
            make.size.equalTo(CGSize(width: 85, height: 290))
        }
        
        contentBGView.addSubview(chooseBGView)
        chooseBGView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 185, height: 40))
        }
        
        chooseBGView.addSubview(womanTitleBtn)
        womanTitleBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(2)
            make.size.equalTo(CGSize(width: 91, height: 36))
        }
        
        chooseBGView.addSubview(manTitleBtn)
        manTitleBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-2)
            make.size.equalTo(CGSize(width: 91, height: 36))
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(35)
            make.top.equalTo(contentBGView.snp.bottom).offset(60)
            make.height.equalTo(58)
        }
    }

    func chooseGender(type: ACVGenderType) {
        self.type = type
        
        if type == .famale {
            womanBtn.isSelected = true
            womanTitleBtn.isSelected = true
            womanTitleBtn.backgroundColor = .init(hex: "#79DC42")
            
            manBtn.isSelected = false
            manTitleBtn.isSelected = false
            manTitleBtn.backgroundColor = .init(hex: "#E8E8E8")
        } else {
            womanBtn.isSelected = false
            womanTitleBtn.isSelected = false
            womanTitleBtn.backgroundColor = .init(hex: "#E8E8E8")
            
            manBtn.isSelected = true
            manTitleBtn.isSelected = true
            manTitleBtn.backgroundColor = .init(hex: "#79DC42")
        }
    }
}
