//
//  ACVUIView+ex.swift
//  ACVPolar
//  
//  Created by _.
//  Copyright © 2025/9/23 _. All rights reserved.
//

import UIKit

extension UIView {
    func toHighQualityImage(scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        format.opaque = isOpaque
        
        let renderer = UIGraphicsImageRenderer(bounds: bounds, format: format)
        return renderer.image { context in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }
}
