//
//  CustomCell.swift
//  Dynamic-AutoLayout-Sample
//
//  Created by kawaharadai on 2018/08/11.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var goodIcon: UIImageView!
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var doneLabel: UILabel!
    // 一度のisActiveの変更で解放されないようWeakにせずに保持
    @IBOutlet var titleToGoodIconConstrant: NSLayoutConstraint!
    @IBOutlet var titleToCountViewConstrant: NSLayoutConstraint!
    @IBOutlet var titleToSuperViewConstrant: NSLayoutConstraint!
    @IBOutlet var goodIconToCountViewConstrant: NSLayoutConstraint!
    @IBOutlet var goodIconToSuperViewConstrant: NSLayoutConstraint!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    /// セルに表示する値をセット
    ///
    /// - Parameters:
    ///   - title: タイトル
    ///   - leftImageName: 左端のイメージアイコン
    ///   - goodCount: いいねの数
    ///   - isNotHiddenGoodIcon: 高評価アイコンを表示するかどうか
    ///   - isNotHiddenGoodCount: いいねの数を表示するかどうか
    func setCellData(title: String,
                     leftImageName: String,
                     goodCount: Int,
                     isNotHiddenGoodIcon: Bool,
                     isNotHiddenGoodCount: Bool) {
        self.titleLabel.text = title
        self.countLabel.text = String(goodCount)
        self.leftImage.image = nil
        self.leftImage.image = UIImage(named: leftImageName)
        self.goodIcon.isHidden = !isNotHiddenGoodIcon
        self.countView.isHidden = !isNotHiddenGoodCount
        self.adjustSubViewConstrant(isNotHiddenGoodIcon: isNotHiddenGoodIcon,
                                    isNotHiddenGoodCount: isNotHiddenGoodCount)
    }
    
    /// subViewの表示の有無によって、セル内のautoLayoutを動的に変更する
    ///
    /// - Parameters:
    ///   - isNotHiddenGoodIcon: 高評価アイコンを表示させるか（true: させる、false: させない）
    ///   - isNotHiddenGoodCount: いいねの数を出すかどうか（true: 出す、 false: 出さない）
    private func adjustSubViewConstrant(isNotHiddenGoodIcon: Bool, isNotHiddenGoodCount: Bool) {
        if isNotHiddenGoodIcon && isNotHiddenGoodCount {
            // 高評価アイコン、いいねの数、両方とも表示する場合
            self.titleToSuperViewConstrant.isActive = false
            self.titleToCountViewConstrant.isActive = false
            self.titleToGoodIconConstrant.isActive = true
            self.goodIconToCountViewConstrant.isActive = true
            self.goodIconToSuperViewConstrant.isActive = false
            // 高評価の作成は視聴済みとする
            self.doneLabel.text = "(視聴済み)"
        } else if !isNotHiddenGoodIcon && isNotHiddenGoodCount {
            // 高評価アイコンは非表示、いいねの数のみの場合
            self.titleToSuperViewConstrant.isActive = false
            self.titleToCountViewConstrant.isActive = true
            self.titleToGoodIconConstrant.isActive = false
            self.goodIconToCountViewConstrant.isActive = false
            self.goodIconToSuperViewConstrant.isActive = false
            self.doneLabel.text = ""
        } else if isNotHiddenGoodIcon && !isNotHiddenGoodCount {
            // 高評価アイコンのみ表示、いいねの数は非表示の場合（例外パターン）
            self.titleToSuperViewConstrant.isActive = false
            self.titleToCountViewConstrant.isActive = false
            self.titleToGoodIconConstrant.isActive = true
            self.goodIconToCountViewConstrant.isActive = false
            self.goodIconToSuperViewConstrant.isActive = true
            self.doneLabel.text = "(視聴済み)"
        } else {
            // 高評価アイコン、いいねの数、両方とも表示しない場合
            self.titleToSuperViewConstrant.isActive = true
            self.titleToCountViewConstrant.isActive = false
            self.titleToGoodIconConstrant.isActive = false
            self.goodIconToCountViewConstrant.isActive = false
            self.goodIconToSuperViewConstrant.isActive = false
            self.doneLabel.text = ""
        }
    }
    
}
