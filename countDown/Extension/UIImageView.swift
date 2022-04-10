//
//  UIImageView.swift
//  countDown
//
//  Created by 林華淵 on 2022/3/22.
//

import Foundation
import UIKit

extension UIImageView {
    func changeTo(color: UIColor){
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
