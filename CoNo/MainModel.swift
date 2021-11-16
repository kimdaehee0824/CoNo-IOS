//
//  MainModel.swift
//  CoNo
//
//  Created by 김대희 on 2021/11/14.
//

import Foundation
import UIKit

struct Covid19struct {
    var STATE_DT : String?
    var DECIDE_CNT : String?
    var NOW_DECIDE_CNT : String?
    var NOW_CLEAR_CNT : String?
    var NOW_DEATH_CNT : String?
    var CLEAR_CNT : String?
    var DEATH_CNT : String?
    var updateDate : String?
    
}
var covid19struct = Covid19struct()

struct DeshViewOffset {
    var backColor : [UIColor?]?
    var labelColor : [UIColor]?
    var bodyTitle : [String]?
    var bodyText : [String?]?
    init() {
        self.backColor = [.clear, UIColor(named: "Color-2"), UIColor(named: "DeathColor"),  UIColor(named: "ClearColor"), UIColor(named: "Color-2"), UIColor(named: "DeathColor"),  UIColor(named: "ClearColor")]
        self.labelColor = [.label, .label, .label, .label, .label, .label, .label]
        self.bodyTitle =  ["", "오늘 확진자", "오늘 사망자", "오늘 격리헤제", "전체 확진자", "전체 사망자", "전체 격리헤제"]
        self.bodyText = [covid19struct.updateDate, covid19struct.NOW_DECIDE_CNT, covid19struct.NOW_DEATH_CNT, covid19struct.NOW_CLEAR_CNT, covid19struct.DECIDE_CNT, covid19struct.DEATH_CNT, covid19struct.CLEAR_CNT]
    }
}
