//
//  UpdateDateLabelTableViewCell.swift
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

class UpdateDateLabelTableViewCell: UITableViewCell {

    var CovidDeviderTitleLabel = UILabel().then {
        dateGet()
        $0.text = covid19struct.updateDate
        $0.font = UIFont(name: "ABeeZee-Regular", size: 20.0)
        $0.textAlignment = .center
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(CovidDeviderTitleLabel)
        CovidDeviderTitleLabel.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
            $0.height.equalTo(20)
            $0.bottom.equalTo(-10)
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
