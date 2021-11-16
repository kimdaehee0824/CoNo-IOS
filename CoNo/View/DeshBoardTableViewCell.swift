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
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.002
        $0.layer.shadowRadius = 20

    }
    let decideDateLabel = UILabel().then {
        $0.font = UIFont(name: "ABeeZee-Regular", size: 25)
        $0.textColor = .white
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(DeshBoardView)

        DeshBoardView.addSubview(decideDateLabel)
        decideDateLabel.translatesAutoresizingMaskIntoConstraints = true
        decideDateLabel.sizeToFit()
        DeshBoardView.snp.makeConstraints {
            $0.top.equalTo(5)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.bottom.equalTo(-5)
        }

        decideDateLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.height.equalTo(35)
            $0.left.equalTo(25)
            $0.right.equalTo(-25)
            $0.bottom.equalTo(-20)
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
