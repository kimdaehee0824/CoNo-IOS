//
//  DeshBoardTableViewCell.swift
//  CoNo
//
//  Created by 김대희 on 2021/11/14.
//
import UIKit
import SnapKit
import Then
import WidgetKit

import RxSwift
import RxCocoa

class DeshBoardTableViewCell: UITableViewCell {

    let DeshBoardView = UIView().then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor.gray.cgColor
        $0.layer.shadowOpacity = 0.002
        $0.layer.shadowRadius = 20
        $0.layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(DeshBoardView)
        DeshBoardView.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.bottom.equalTo(-10)
            $0.height.equalTo(250)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
