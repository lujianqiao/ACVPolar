//
//  ACVConst.swift
//  ACVPolar
//  
//  Created by _.
//  Copyright © 2025/8/7 _. All rights reserved.
//

import UIKit
import CoreTelephony

public let kScreenWidth: Double = UIScreen.main.bounds.size.width
public let kScreenHeight: Double = UIScreen.main.bounds.size.height
/// 获取keywindow
public var kWindow: UIWindow? { UIApplication.shared.topWindow }

// MARK: 安全距离相关
/// 状态栏高度
public var kStatusBarHeight: Double { UIApplication.shared.statusBarFrame.size.height }
/// 导航栏高度
public var kNavigationBarHeight: CGFloat { 44.0 }
/// 顶部导航栏高度(状态栏和导航栏的高度)
public var kNavHeight: CGFloat { kStatusBarHeight + kNavigationBarHeight }
/// 底部安全区域总高度
public var kSafeMarginHeight: CGFloat { kNavHeight + kSafeBottomMargin }
/// 标签栏高度
public var kTabbarHeight: CGFloat { iPhoneXSeries ? (49.0 + kSafeBottomMargin) : 49.0 }
/// 顶部安全区域高度
public var kSafeTopMargin: CGFloat {
    if #available(iOS 13.0, *) {
        return kWindow?.safeAreaInsets.top ?? .zero
    } else if #available(iOS 11.0, *) {
        return kWindow?.safeAreaInsets.top ?? .zero
    } else {
        return .zero
    }
}
/// 底部安全区域高度
public var kSafeBottomMargin: CGFloat {
    if #available(iOS 13.0, *) {
        return kWindow?.safeAreaInsets.bottom ?? .zero
    } else if #available(iOS 11.0, *) {
        return kWindow?.safeAreaInsets.bottom ?? .zero
    } else {
        return .zero
    }
}
/// 是否是iphonex系列
public var iPhoneXSeries: Bool {
    guard #available(iOS 11.0, *),
          (kWindow?.safeAreaInsets.bottom ?? 0.0) > 0.0 else {
        return false
    }
    return true
}
/// 是不是暗黑模式
public var isDarkMode: Bool {
    // iOS 12 以下不支持暗模式
    guard #available(iOS 12.0, *) else { return false }
    return UIScreen.main.traitCollection.userInterfaceStyle == .dark
}

struct ACVConst {
    
    static let ACV_userTokenKey = "userTokenKey"
    
    static let ACV_userBTokenKey = "userBTokenKey"
    
    static let ACV_userAccountKey = "userAccountKey"
    
    static let ACV_userAvatarKey = "userAvatar"
    
    static let ACV_userChatDataKey = "userChatDataKey"
    
    static let ACV_userPassword = "userPassword"
    
    static let ACV_userBPassword = "userBPassword"
    
    static let ACV_userBuyList = "userBuyList"
    
    /// APP名称
    static var ACVAppDisplayName: String {
        let infoDictionary: Dictionary? = Bundle.main.infoDictionary
        let kAppDisplayName = infoDictionary?["CFBundleDisplayName"] as? String ?? ""
        return kAppDisplayName
    }
    
    
    /// APP版本号
    static var ACVAppCurrentVersion: String {
        let infoDictionary: Dictionary? = Bundle.main.infoDictionary
        let kAppCurrentVersion = infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        return kAppCurrentVersion
    }
    
    /// 设备号
    static var ACVUniqueDeviceID: String {
        if let uuidString = UserDefaults.standard.object(forKey: "device_uuid") {
            if let uuid = uuidString as? String {
                return uuid
            }
        }
        
        let uuid = UUID().uuidString
        UserDefaults.standard.setValue(uuid, forKey: "device_uuid")
        UserDefaults.standard.synchronize()
        return uuid
    }
    
    /// 获取SceneDelegate
    static func ACVGetSceneDelegate() -> SceneDelegate? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return nil
        }
        return sceneDelegate
    }
    
    /// 获取信息
    static func ACVGetUserDefaultsData(with key: String) -> String? {
        let auth = UserDefaults.standard.value(forKey: key) as? String
        return auth
    }
    
    
    /// 保存信息
    static func ACVSetUserDefaultsData(with data: String?, key: String) {
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    /// 获取信息
    static func ACVGetUserDefaultsArrayData(with key: String) -> [String]? {
        let auth = UserDefaults.standard.value(forKey: key) as? [String]
        return auth
    }
    
    
    /// 保存信息
    static func ACVSetUserDefaultsArrayData(with data: String?, key: String) {
        
        guard let value = data else {return}
        var datas: [String] = []
        if let values = ACVConst.ACVGetUserDefaultsArrayData(with: ACVConst.ACV_userBuyList) {
            datas = values
        }
        datas.append(value)
        
        UserDefaults.standard.set(datas, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    
    /// 获取数据
    static func ACVGetUserDefaultsValue(with key: String) -> Data? {
        let value = UserDefaults.standard.value(forKey: key) as? Data
        return value
    }
    
    
    /// 保存数据
    static func ACVSetUserDefaultsValue(with data: Data?, key: String) {
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    /// 是否使用SIM卡
    static func ACVIsSIMInserted() -> Bool {
        let networkInfo = CTTelephonyNetworkInfo()
        guard let carriers = networkInfo.serviceSubscriberCellularProviders else {
            return false
        }
        
        // 检查所有运营商是否为空（无SIM卡）
        return !carriers.values.allSatisfy { $0.mobileCountryCode == nil }
    }
    
    /// 是否使用VPN
    static func ACVIsVPNConnected() -> Bool {
        guard let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
              let scoped = settings["__SCOPED__"] as? [String: Any] else {
            return false
        }
        
        for (key, _) in scoped {
            if key.contains("tap") || key.contains("tun") || key.contains("ppp") || key.contains("ipsec") {
                return true
            }
        }
        return false
    }
    
    /// 是否是中国运营商
    static func ACVIsChineseCarrier() -> Bool {
        // 获取运营商信息
        let networkInfo = CTTelephonyNetworkInfo()
        
        // 获取当前的 SIM 信息（多 SIM 卡支持）
        let carriers = networkInfo.serviceSubscriberCellularProviders
        let mccCode = "460" // 中国的 MCC 值
        
        // 遍历所有 SIM 卡
        for (_, carrier) in carriers ?? [:] {
            if let mobileCountryCode = carrier.mobileCountryCode, mobileCountryCode == mccCode {
                return true // 是中国的运营商
            }
        }
        
        return false // 不是中国的运营商
    }
    
}
