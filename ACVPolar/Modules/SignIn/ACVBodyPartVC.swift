//
//  ACVBodyPartVC.swift
//  ACVPolar
//  
//  Created by _.
//  Copyright © 2025/9/23 _. All rights reserved.
//

import UIKit

enum ACVBodyPartType: Int {
    case fullBody = 1
    case waist = 2
    case arm = 3
    case abdomen = 4
    case hips = 5
    case leg = 6
}

class ACVBodyPartVC: ACVBaseViewController {

    private var part: ACVBodyPartType = .fullBody
    
    lazy var bgImageView: UIImageView = {
        let image: UIImageView = .init()
        image.image = UIImage(named: "SI_BG")
        return image
    }()
    
    lazy var titleImageView: UIImageView = {
        let image: UIImageView = .init()
        image.image = UIImage(named: "SI_userinfo_bp_title")
        return image
    }()
    
    lazy var contentBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    
    lazy var manView: UIImageView = {
        let image: UIImageView = .init()
        image.image = UIImage(named: "SI_userinfo_bp_woman")
        return image
    }()
    
    lazy var fullBodyBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setBackgroundImage(UIImage(named: "SI_userinfo_bp_bg_normal"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "SI_userinfo_bp_bg_select"), for: .selected)
        btn.setTitle("Full body", for: .normal)
        btn.setTitleColor(.init(hex: "#9B9A9E"), for: .normal)
        btn.setTitleColor(.black, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.isSelected = true
        btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.selectBodyPart(type: .fullBody)
        }).disposed(by: rx.disposeBag)
        return btn
    }()
    
    lazy var waistBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setBackgroundImage(UIImage(named: "SI_userinfo_bp_bg_normal"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "SI_userinfo_bp_bg_select"), for: .selected)
        btn.setTitle("Waist", for: .normal)
        btn.setTitleColor(.init(hex: "#9B9A9E"), for: .normal)
        btn.setTitleColor(.black, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.isSelected = false
        btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.selectBodyPart(type: .waist)
        }).disposed(by: rx.disposeBag)
        return btn
    }()
    
    lazy var armBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setBackgroundImage(UIImage(named: "SI_userinfo_bp_bg_normal"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "SI_userinfo_bp_bg_select"), for: .selected)
        btn.setTitle("Arm", for: .normal)
        btn.setTitleColor(.init(hex: "#9B9A9E"), for: .normal)
        btn.setTitleColor(.black, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.isSelected = false
        btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.selectBodyPart(type: .arm)
        }).disposed(by: rx.disposeBag)
        return btn
    }()
    
    lazy var abdomenBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setBackgroundImage(UIImage(named: "SI_userinfo_bp_bg_normal"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "SI_userinfo_bp_bg_select"), for: .selected)
        btn.setTitle("Abdomen", for: .normal)
        btn.setTitleColor(.init(hex: "#9B9A9E"), for: .normal)
        btn.setTitleColor(.black, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.isSelected = false
        btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.selectBodyPart(type: .abdomen)
        }).disposed(by: rx.disposeBag)
        return btn
    }()
    
    lazy var hipsBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setBackgroundImage(UIImage(named: "SI_userinfo_bp_bg_normal"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "SI_userinfo_bp_bg_select"), for: .selected)
        btn.setTitle("Hips", for: .normal)
        btn.setTitleColor(.init(hex: "#9B9A9E"), for: .normal)
        btn.setTitleColor(.black, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.isSelected = false
        btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.selectBodyPart(type: .hips)
        }).disposed(by: rx.disposeBag)
        return btn
    }()
    
    lazy var legBtn: UIButton = {
        let btn: UIButton = .init()
        btn.setBackgroundImage(UIImage(named: "SI_userinfo_bp_bg_normal"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "SI_userinfo_bp_bg_select"), for: .selected)
        btn.setTitle("Leg", for: .normal)
        btn.setTitleColor(.init(hex: "#9B9A9E"), for: .normal)
        btn.setTitleColor(.black, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.isSelected = false
        btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.selectBodyPart(type: .leg)
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

    func setUI() {
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { make in
            make.left.equalTo(35)
            make.top.equalTo(kNavHeight + 25)
            make.size.equalTo(CGSize(width: 266, height: 48))
        }
        
        view.addSubview(contentBGView)
        contentBGView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(titleImageView.snp.bottom).offset(18)
            make.height.equalTo(393)
        }
        
        contentBGView.addSubview(manView)
        manView.snp.makeConstraints { make in
            make.left.equalTo(34)
            make.top.equalTo(46)
            make.size.equalTo(CGSize(width: 181, height: 335))
        }
        
        contentBGView.addSubview(fullBodyBtn)
        fullBodyBtn.snp.makeConstraints { make in
            make.top.equalTo(57)
            make.left.equalTo(manView.snp.right)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        contentBGView.addSubview(waistBtn)
        waistBtn.snp.makeConstraints { make in
            make.top.equalTo(fullBodyBtn.snp.bottom).offset(10)
            make.left.equalTo(manView.snp.right)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        contentBGView.addSubview(armBtn)
        armBtn.snp.makeConstraints { make in
            make.top.equalTo(waistBtn.snp.bottom).offset(10)
            make.left.equalTo(manView.snp.right)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        contentBGView.addSubview(abdomenBtn)
        abdomenBtn.snp.makeConstraints { make in
            make.top.equalTo(armBtn.snp.bottom).offset(10)
            make.left.equalTo(manView.snp.right)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        contentBGView.addSubview(hipsBtn)
        hipsBtn.snp.makeConstraints { make in
            make.top.equalTo(abdomenBtn.snp.bottom).offset(10)
            make.left.equalTo(manView.snp.right)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        contentBGView.addSubview(legBtn)
        legBtn.snp.makeConstraints { make in
            make.top.equalTo(hipsBtn.snp.bottom).offset(10)
            make.left.equalTo(manView.snp.right)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(35)
            make.top.equalTo(contentBGView.snp.bottom).offset(60)
            make.height.equalTo(58)
        }
    }
    
}

extension ACVBodyPartVC {
    
    func selectBodyPart(type: ACVBodyPartType) {
        
        guard type != self.part else {return}
        self.part = type
        fullBodyBtn.isSelected = false
        waistBtn.isSelected = false
        armBtn.isSelected = false
        abdomenBtn.isSelected = false
        hipsBtn.isSelected = false
        legBtn.isSelected = false
        
        switch type {
        case .fullBody:
            fullBodyBtn.isSelected = true
        case .waist:
            waistBtn.isSelected = true
        case .arm:
            armBtn.isSelected = true
        case .abdomen:
            abdomenBtn.isSelected = true
        case .hips:
            hipsBtn.isSelected = true
        case .leg:
            legBtn.isSelected = true
        }
    }
    
}
