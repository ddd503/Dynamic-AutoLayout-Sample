//
//  TableViewController.swift
//  Dynamic-AutoLayout-Sample
//
//  Created by kawaharadai on 2018/08/11.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // (0: タイトル, 1: いいねの数, 2: 高評価アイコンの有無、3: いいねの数表示の有無)
    private let titles = [("Mamma Mia! Here We Go Again", 100000),
                          ("Jurassic World The Kingdom of Flames", 3000),
                          ("Mission Impossible Fallout", 500000),
                          ("Pocket Monsters' Everyone's Story", 999),
                          ("Hotel Transylvania 3: Summer Vacation", 1001)]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.tableView.register(UINib(nibName: CustomCell.identifier, bundle: nil),
                                forCellReuseIdentifier: CustomCell.identifier)
        self.tableView.tableFooterView = UIView()
    }
    
    // MARK: - Action
        @IBAction func refresh(_ sender: UIBarButtonItem) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            fatalError("cell is nil")
        }
        
        /*
         セル毎の表示制約
         ・いいねの数が10000以上なら高評価アイコンを表示する
         ・いいねの数が1000以下なら、いいねの数自体を非表示にする
         デバッグ用のLLDBコマンド
         thread jump --by 5
         expression cell.setCellData(title: "テストテストテストテストテストテストテストテストテストテストテストテストテスト", leftImageName: String(indexPath.row + 1), goodCount: 1000000, isNotHiddenGoodIcon: false, isNotHiddenGoodCount: false)
         */
        cell.setCellData(title: titles[indexPath.row].0,
                         leftImageName: String(indexPath.row + 1),
                         goodCount: titles[indexPath.row].1,
                         isNotHiddenGoodIcon: self.isHighRating(goodCount: titles[indexPath.row].1, borderOfHighRate: 10000),
                         isNotHiddenGoodCount: self.isHighRating(goodCount: titles[indexPath.row].1, borderOfHighRate: 1000))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // セル表示の直前にレイアウトをいじる
        if let cell = cell as? CustomCell {
            // left image
            self.adjustViewLayout(view: cell.leftImage,
                                  cornerRadius: cell.leftImage.frame.size.width / 2)
            cell.countView.backgroundColor = .red
            // countView
            self.adjustViewLayout(view: cell.countView, cornerRadius: 10)
            // icon
            self.adjustViewLayout(view: cell.goodIcon, cornerRadius: cell.goodIcon.frame.size.width / 2)
            // contentView
            cell.contentView.backgroundColor = .lightGray
        }
    }
    
    // MARK: - Private
    
    /// いいねの数が規定値より高いかどうか
    ///
    /// - Parameters:
    ///   - goodCount: いいねの数
    ///   - borderOfHighRate: 規定値
    /// - Returns: true: 規定値以上、false: 規定値より小さい
    private func isHighRating(goodCount: Int, borderOfHighRate: Int) -> Bool {
        return goodCount >= borderOfHighRate
    }
    
    /// Viewを丸角にする
    ///
    /// - Parameters:
    ///   - view: 任意のUIView
    ///   - cornerRadius: どれだけ丸めるか
    func adjustViewLayout(view: UIView, cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
    }
}
