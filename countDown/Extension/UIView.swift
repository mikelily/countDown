//
//  UIView.swift
//  countDown
//
//  Created by 林華淵 on 2022/3/26.
//

import Foundation
import UIKit

extension UIView {
    func setBackColorViewTo(targetView: UIView,targetColor: UIColor){
        let bcView = UIView()
        bcView.backgroundColor = targetColor
        
        self.addSubview(bcView)
        bcView.snp.makeConstraints { make in
            make.top.left.equalTo(targetView).offset(-padding/2)
            make.right.bottom.equalTo(targetView).offset(padding/2)
        }
        
        self.sendSubviewToBack(bcView)
    }
}
