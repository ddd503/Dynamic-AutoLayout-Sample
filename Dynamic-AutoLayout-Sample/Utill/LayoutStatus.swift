//
//  LayoutStatus.swift
//  Dynamic-AutoLayout-Sample
//
//  Created by kawaharadai on 2018/09/01.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

enum LayoutStatus {
    case nothing // 通常
    case count // いいねの数
    case good // 高評価アイコン＆いいねの数
    case exception // 高評価アイコンのみ
}

extension LayoutStatus {
    
    init(hasIcon: Bool, hasGood: Bool) {
        switch (hasIcon, hasGood) {
        case (false, false):
            self = .nothing
        case (false, true):
            self = .count
        case (true, true):
            self = .good
        case (true, false):
            self = .exception
        }
    }
    
}
