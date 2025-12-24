//
//  UIColorExtension.swift
//  SberQlet
//
//  Created by User on 21.12.2025.
//

import UIKit

extension UIColor {
    
    convenience init(_ colors: (ColorModel, ColorModel)?) {
        self.init { traitCollection in
            var color: ColorModel?
            if traitCollection.userInterfaceStyle == .light {
                color = colors?.0
            } else {
                color = colors?.1
            }
            guard let color else {
                return .clear
            }
            return UIColor(
                red: color.red,
                green: color.green,
                blue: color.blue,
                alpha: color.alpha
            )
        }
    }
}
