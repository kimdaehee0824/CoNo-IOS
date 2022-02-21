//
//  MainViewController.swift
//  CoNo
//
//  Created by 김대희 on 2021/11/11.
//

import UIKit
import SnapKit
import Then
import WidgetKit
import UserNotifications
import RxSwift
import RxCocoa
import SafariServices

class MainViewController: UIViewController {
    
    let bag = DisposeBag()
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    let mainTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.estimatedRowHeight = 68.0
        $0.rowHeight = UITableView.automaticDimension
    }
    
    let mainBackView = UIView().then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let personButton = UIBarButtonItem().then {
        let personImage = UIImage(systemName: "person.circle")
        $0.image = personImage
        $0.tintColor = .label
    }
    
    let moveCovidBoardButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "DeathColor")
        $0.setTitle("Coronaboard로 이동하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.02
        $0.layer.shadowRadius = 20

    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveTestNotification(_:)), name: NSNotification.Name("TestNotification"), object: nil)
        super.viewDidLoad()
        CovidData.data.dateGet()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        sendNotification(seconds: 1)
        mainTableView.reloadData()
        mainTableView.register(DeshBoardTableViewCell.self, forCellReuseIdentifier: "cell")
        mainTableView.register(UpdateDateLabelTableViewCell.self, forCellReuseIdentifier: "cell2")
        view.addSubview(mainBackView)
        mainBackView.addSubview(mainTableView)
        mainBackView.addSubview(moveCovidBoardButton)
        moveCovidBoardButton.rx.tap.bind {
            guard let url = URL(string: "https://coronaboard.kr") else { return }
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.modalPresentationStyle = .fullScreen

            self.present(safariViewController, animated: true, completion: nil)
        }.disposed(by: bag)
        setNavagationBar()
        setConstraint()
        setSafeArea()
    }
    func sendNotification(seconds: Double) {
        CovidData.data.dateGet()
        let notificationContent = UNMutableNotificationContent()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            notificationContent.title = "오늘의 확진자"
            let nowDecideCount = covid19struct.NOW_DECIDE_CNT ?? ""
            let nowDeathCount = covid19struct.NOW_DEATH_CNT ?? ""
            let nowClearCount = covid19struct.NOW_CLEAR_CNT ?? ""
            notificationContent.body = "확진자 : \(DecimalNumber(value: Int(nowDecideCount) ?? 0)), 사망자 : \(DecimalNumber(value: Int(nowDeathCount) ?? 0)), 격리해제 : \(DecimalNumber(value: Int(nowClearCount) ?? 0))"
            
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
            dateComponents.hour = 9
            dateComponents.minute = 30
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: "testNotification",
                                                content: notificationContent,
                                                trigger: trigger)
            self.userNotificationCenter.add(request) { error in
                if let error = error {
                    print("Notification Error: ", error)
                }
            }
        }
        
    }
    func setConstraint() {
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
            $0.bottom.equalTo(0)
        }
        moveCovidBoardButton.snp.makeConstraints {
            $0.bottom.equalTo(-5)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.height.equalTo(60)
        }
    }
    func setSafeArea() {
        mainBackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainBackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainBackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainBackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setNavagationBar() {
        self.view.backgroundColor = .systemGroupedBackground
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let image = UIImage(named: "CoNoTitle")
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.navigationItem.rightBarButtonItem = personButton
    }
}
extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let Ccell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! UpdateDateLabelTableViewCell
            let bgColorView = UIView()
            bgColorView.backgroundColor = .clear
            Ccell.selectedBackgroundView = bgColorView
            Ccell.backgroundColor = .systemGroupedBackground
            Ccell.CovidDeviderTitleLabel.text = "\(covid19struct.updateDate ?? "데이터가 없어요")일 기준"
            return Ccell
        }
        else {
            let deshViewOffset = DeshViewOffset()
            let Ccell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DeshBoardTableViewCell
            let bgColorView = UIView()
            Ccell.DeshBoardView.backgroundColor = .secondarySystemGroupedBackground
            Ccell.decideDateLabel.textColor = deshViewOffset.labelColor?[indexPath.row]
            let celltext : String = deshViewOffset.bodyText?[indexPath.row] ?? ""
            Ccell.backgroundColor = .systemGroupedBackground
            Ccell.decideDateLabel.text = "\(deshViewOffset.bodyTitle?[indexPath.row] ?? "") : \(DecimalNumber(value: Int(celltext) ?? 0))"
            bgColorView.backgroundColor = .clear
            Ccell.selectedBackgroundView = bgColorView
            return Ccell
        }
    }
    @objc func didRecieveTestNotification(_ notification: Notification) {
        print("Test Notification")
        self.mainTableView.reloadData()
    }
}

func DecimalNumber(value: Int) -> String{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    let result = numberFormatter.string(from: NSNumber(value: value))! + "명"
    
    return result
}
