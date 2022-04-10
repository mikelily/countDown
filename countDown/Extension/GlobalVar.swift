//
//  GlobalVar.swift
//  countDown
//
//  Created by 林華淵 on 2022/3/22.
//

import Foundation
import UIKit

/// 取得裝置大小
let fullScreenSize = UIScreen.main.bounds.size

let statusBarHeight = UIApplication.shared.statusBarFrame.height

let bottomSafeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0

let padding: CGFloat = 10
let cellWidth: CGFloat = (fullScreenSize.width - padding*2 - padding*3 )/2
let cellHeight: CGFloat = 100
