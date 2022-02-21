//
//  DataResponse.swift
//  CoNo
//
//  Created by 김대희 on 2021/11/11.
//

import Foundation
import Alamofire
import WidgetKit
import SwiftyXMLParser

let apiKey = "6v8BYgD7fIO1KjC3kqQ6w73J7NCGn%2BwAdqZT7WjhN%2BubaEF50QO9YalOb8ZFZzkl5nTXjtJAjdbrncrJJGwvAw%3D%3D"
let DateData = Date()
let yesData = Date(timeIntervalSinceNow:-(60*60*24))
//http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=\(apiKey)&pageNo=1&numOfRows=10&startCreateDt=\(yesconvertDate)&endCreateDt=\(convertDate)

class CovidData {
    static let data = CovidData()
    var decideJustNumber = ""
    
    func requstSecideCount() -> String? {
        let fommatter = DateFormatter()
        fommatter.dateFormat = "yyyyMMdd"
        let convertDate = fommatter.string(from: .now)
        let yesconvertDate = fommatter.string(from: yesData)
        
        
        AF.request(" http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=\(apiKey)&pageNo=1&numOfRows=10&startCreateDt=\(yesconvertDate)&endCreateDt=\(convertDate)", method: .get )
            .validate(statusCode: 200..<300)
            .responseString { response in
                let url = response.request
                print(url!)
                print("Xml : \n\(response)")
                switch response.result {
                case .success:
                    print(" 성공")
                    guard let data = response.data else { return }
                    let xml2 = try? XML.parse(data)
                    if let decideCount = xml2?["response", "body", "items", "item", 0, "decideCnt"].text {
                        print("전날 코로나 확진자")
                        print(decideCount)
                        covid19struct.DECIDE_CNT = "\(decideCount)"
                        if let lestdecideCount = xml2?["response", "body", "items", "item", 1, "decideCnt"].text {
                            print("일 코로나 확진자")
                            guard let qw = Int(lestdecideCount) else {return}
                            guard let we = Int(decideCount) else {return}
                            print(we - qw)
                            self.decideJustNumber = "\(we - qw)"
                            covid19struct.NOW_DECIDE_CNT = "\(we - qw)"
                            WidgetCenter.shared.reloadAllTimelines()
                        } else {
                            print("오늘 값 없음!!")
                        }
                    } else {
                        print("값 없음!!")
                    }
                case .failure(let error):
                    print("Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
        print("0======-=-=-=-=-=-=-=-=")
        print(decideJustNumber)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [self] in
            print(decideJustNumber)
        }
        return decideJustNumber
    }
    func dateGet() {
        let fommatter = DateFormatter()
        fommatter.dateFormat = "yyyyMMdd"
        let convertDate = fommatter.string(from: .now)
        let yesconvertDate = fommatter.string(from: yesData)
        
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
                        print("전날 코로나 확진자")
                        print(decideCount)
                        covid19struct.DECIDE_CNT = "\(decideCount)"
                        if let lestdecideCount = xml2?["response", "body", "items", "item", 1, "decideCnt"].text {
                            print("일 코로나 확진자")
                            guard let qw = Int(lestdecideCount) else {return}
                            guard let we = Int(decideCount) else {return}
                            print(we - qw)
                            self.decideJustNumber = "\(we - qw)"
                            covid19struct.NOW_DECIDE_CNT = "\(we - qw)"
                            WidgetCenter.shared.reloadAllTimelines()
                        } else {
                            print("오늘 값 없음!!")
                        }
                    } else {
                        print("값 없음!!")
                    }
                    if let deathCnt = xml2?["response", "body", "items", "item", 0, "deathCnt"].text {
                        print("전날 사망자")
                        print(deathCnt)
                        covid19struct.DEATH_CNT = "\(deathCnt)"
                        if let lestdeathCnt = xml2?["response", "body", "items", "item", 1, "deathCnt"].text {
                            print("일 사망자")
                            guard let qw = Int(lestdeathCnt) else {return}
                            guard let we = Int(deathCnt) else {return}
                            print(we - qw)
                            covid19struct.NOW_DEATH_CNT = "\(we-qw)"
                        }
                    }
                    if let clearCnt = xml2?["response", "body", "items", "item", 0, "clearCnt"].text {
                        print("전날 격리헤제")
                        print(clearCnt)
                        covid19struct.CLEAR_CNT = "\(clearCnt)"
                        if let lestclearCnt = xml2?["response", "body", "items", "item", 1, "clearCnt"].text {
                            print("일 격리헤제")
                            guard let qw = Int(lestclearCnt) else {return}
                            guard let we = Int(clearCnt) else {return}
                            print(we - qw)
                            covid19struct.NOW_CLEAR_CNT = "\(we - qw)"
                            
                        }
                    }
                    if let stateDt = xml2?["response", "body", "items", "item", 0, "stateDt"].text {
                        print(stateDt)
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyyMMdd"
                        let date  = dateFormatter.date(from: stateDt)
                        
                        let fommatter = DateFormatter()
                        fommatter.dateFormat = "yyyy.MM.dd"
                        let updateDate = fommatter.string(from: date ?? .now)
                        covid19struct.updateDate = "\(updateDate)"
                        NotificationCenter.default.post(name: NSNotification.Name("TestNotification"), object: nil, userInfo: nil)
                    }
                    
                case .failure(let error):
                    print("Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
    }
}

