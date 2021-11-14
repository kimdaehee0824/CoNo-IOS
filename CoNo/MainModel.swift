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
    var backColor : [UIColor]
    var labelColor : [UIColor]
    var bodyText : [String]
}
