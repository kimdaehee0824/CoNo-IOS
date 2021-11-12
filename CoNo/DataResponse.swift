//
//  DataResponse.swift
//  CoNo
//
//  Created by 김대희 on 2021/11/11.
//

import Foundation
import Alamofire

import SwiftyXMLParser

let apiKey = "6v8BYgD7fIO1KjC3kqQ6w73J7NCGn%2BwAdqZT7WjhN%2BubaEF50QO9YalOb8ZFZzkl5nTXjtJAjdbrncrJJGwvAw%3D%3D"
let baseUrl = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=\(apiKey)&pageNo=1&numOfRows=10&startCreateDt=20211111&endCreateDt=20211111"
let DateData = Date()
let yesData = Date(timeIntervalSinceNow:-(60*60*24))

struct covid19struct {
    let STATE_DT : String
    let DECIDE_CNT : String
    let CLEAR_CNT : String
    let DEATH_CNT : String
    let CARE_CNT : String
    
}

func dateGet() {
    let fommatter = DateFormatter()
    fommatter.dateFormat = "yyyyMMdd"
    let convertDate = fommatter.string(from: .now)
    let yesconvertDate = fommatter.string(from: yesData)
    
    // http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=6v8BYgD7fIO1KjC3kqQ6w73J7NCGn%2BwAdqZT7WjhN%2BubaEF50QO9YalOb8ZFZzkl5nTXjtJAjdbrncrJJGwvAw%3D%3D&pageNo=1&numOfRows=10&startCreateDt=20211111&endCreateDt=20211111
    // http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=6v8BYgD7fIO1KjC3kqQ6w73J7NCGn%2BwAdqZT7WjhN%2BubaEF50QO9YalOb8ZFZzkl5nTXjtJAjdbrncrJJGwvAw%3D%3D&pageNo=1&numOfRows=10&startCreateDt=20211112&endCreateDt=20211112
    // http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=\(apiKey)&pageNo=1&numOfRows=10&startCreateDt=\(convertDate)&endCreateDt=\(convertDate)
    AF.request("http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=\(apiKey)&pageNo=1&numOfRows=10&startCreateDt=\(yesconvertDate)&endCreateDt=\(convertDate)", method: .get )
        .validate(statusCode: 200..<300)
        .responseString { response in
            let url = response.request
            print(url!)
            print("Xml : \n\(response)")
            switch response.result {
            case .success:
                print(" 성공")
                if let string = response.data {
                    print("XML: \(string)")
                }
                
                guard let data = response.data else { return }
                
                print(data)
                let xml2 = try? XML.parse(data)
                if let decideCount = xml2?["response", "body", "items", "item", 0, "decideCnt"].text {
                    print("총 코로나 확진자")
                    print(decideCount)
                    if let lestdecideCount = xml2?["response", "body", "items", "item", 1, "decideCnt"].text {
                        print("일 코로나 확진자")
                        guard let qw = Int(lestdecideCount) else {return}
                        guard let we = Int(decideCount) else {return}
                        print(we - qw)
                    }
                }
                if let deathCnt = xml2?["response", "body", "items", "item", 0, "deathCnt"].text {
                    print("총 사망자")
                    print(deathCnt)
                    if let lestdeathCnt = xml2?["response", "body", "items", "item", 1, "deathCnt"].text {
                        print("일 사망자")
                        guard let qw = Int(lestdeathCnt) else {return}
                        guard let we = Int(deathCnt) else {return}
                        print(we - qw)
                    }

                }
            case .failure(let error):
                print("Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                
            }
        }
}


let str2 = """
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<response>
    <header>
        <resultCode>00</resultCode>
        <resultMsg>NORMAL SERVICE.</resultMsg>
    </header>
    <body>
        <items>
            <item>
                <accDefRate>2.6310850842</accDefRate>
                <accExamCnt>16312775</accExamCnt>
                <accExamCompCnt>14760108</accExamCompCnt>
                <careCnt>30304</careCnt>
                <clearCnt>355014</clearCnt>
                <createDt>2021-11-11 09:27:17.639</createDt>
                <deathCnt>3033</deathCnt>
                <decideCnt>388351</decideCnt>
                <examCnt>1552667</examCnt>
                <resutlNegCnt>14371757</resutlNegCnt>
                <seq>694</seq>
                <stateDt>20211111</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>null</updateDt>
            </item>
        </items>
        <numOfRows>10</numOfRows>
        <pageNo>1</pageNo>
        <totalCount>1</totalCount>
    </body>
</response>
"""


