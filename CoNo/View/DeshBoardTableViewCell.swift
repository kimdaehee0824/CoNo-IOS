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
    let decideTitleLabel = UILabel().then {
        $0.text = "Today"
        $0.font = UIFont(name: "ABeeZee-Regular", size: 20)
        $0.textAlignment = .center
        $0.textColor = .label
        
    }
    let decideDateLabel = UILabel().then {
        $0.text = "1234명 확진"
        $0.font = UIFont(name: "NotoSansKR-Bold", size: 35)
        $0.textAlignment = .center
        $0.textColor = .label
    }
    let deathDateLabel = UILabel().then {
        $0.text = "14명 사망"
        $0.font = UIFont(name: "NotoSansKR-Bold", size: 35)
        $0.textAlignment = .center
        $0.textColor = .systemRed
    }
    let clearDateLabel = UILabel().then {
        $0.text = "1423명 격리헤제"
        $0.font = UIFont(name: "NotoSansKR-Bold", size: 35)
        $0.textAlignment = .center
        $0.textColor = .systemBlue
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(DeshBoardView)

        DeshBoardView.addSubview(decideDateLabel)
        DeshBoardView.addSubview(deathDateLabel)
        DeshBoardView.addSubview(clearDateLabel)
        DeshBoardView.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
        }

        decideDateLabel.snp.makeConstraints {
            $0.top.equalTo(30)
            $0.height.equalTo(35)
            $0.left.equalTo(5)
            $0.right.equalTo(-5)
        }
        deathDateLabel.snp.makeConstraints {
            $0.top.equalTo(90)
            $0.height.equalTo(35)
            $0.left.equalTo(5)
            $0.right.equalTo(-5)
        }
        clearDateLabel.snp.makeConstraints {
            $0.top.equalTo(150)
            $0.height.equalTo(35)
            $0.left.equalTo(5)
            $0.right.equalTo(-5)
            $0.bottom.equalTo(-30)
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
