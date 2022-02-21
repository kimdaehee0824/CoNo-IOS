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
    var labelColor : [UIColor]?
    var bodyTitle : [String]?
    var bodyText : [String?]?
    init() {
        self.labelColor = [.label, .label, .label, .label, .label, .label, .label]
        self.bodyTitle =  ["", "오늘 확진자", "오늘 사망자", "전체 확진자", "전체 사망자"]
        self.bodyText = [covid19struct.updateDate, covid19struct.NOW_DECIDE_CNT, covid19struct.NOW_DEATH_CNT, covid19struct.DECIDE_CNT, covid19struct.DEATH_CNT]
    }
}
