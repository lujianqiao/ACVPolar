//
//  ACVNavigationAppearance.swift
//  ACVPolar
//  
//  Created by _.
//  Copyright © 2025/8/7 _. All rights reserved.
//

import UIKit

public class ACVNavigationAppearance {
    public typealias GlobalHandler = () -> Void
    public static let appearance: ACVNavigationAppearance = .init()
    /// title color
    public var titleColor: UIColor = .black
    /// title font
    public var titleFont: UIFont = .systemFont(ofSize: 18, weight: .bold)
    /// 背景颜色 - 不支持暗黑模式
    public var backgroundColor: UIColor = .clear
    /// 背景图片 - 支持暗黑模式
    public var backgroundImage: UIImage?
    /// 返回按钮图标
    public var backImage: UIImage? = UIImage(named: "nav_back")
    /// 统一的返回按钮事件 - 可以通过LKRNavigationController内部的backHandler处理单独的事件
    public var globalBackHandler: GlobalHandler?
}
