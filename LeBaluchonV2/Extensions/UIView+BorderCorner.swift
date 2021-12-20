//
//  UIView+BorderCorner.swift
//  LeBaluchonV2
//
//  Created by Nicolas Demange on 16/12/2021.
//

import UIKit

extension UIView {
  @IBInspectable var cornerRadius: CGFloat {
   get{
        return layer.cornerRadius
    }
    set {
        layer.cornerRadius = newValue
        layer.masksToBounds = newValue > 0
    }
  }
}
