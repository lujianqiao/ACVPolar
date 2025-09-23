//
//  ACVInt+ex.swift
//  ACVPolar
//  
//  Created by _.
//  Copyright © 2025/8/7 _. All rights reserved.
//

import Foundation

extension Int {
    
    /// 屏幕比例
    var scale: Double {
        return Double(self) * (kScreenWidth / 375)
    }
    
}
