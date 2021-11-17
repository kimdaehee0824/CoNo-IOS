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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        CovidData.data.dateGet()
        print("2121212121\(CovidData.data.requstSecideCount() ?? "sadasdsad")")
        requestNotificationAuthorization()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.mainTableView.reloadData()
        }
        mainTableView.reloadData()
        mainTableView.register(DeshBoardTableViewCell.self, forCellReuseIdentifier: "cell")
        mainTableView.register(UpdateDateLabelTableViewCell.self, forCellReuseIdentifier: "cell2")
        view.backgroundColor = .systemBackground
        view.addSubview(mainBackView)
        mainBackView.addSubview(mainTableView)
        setNavagationBar()
        setConstraint()
        setSafeArea()
    }
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

           userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
               if let error = error {
                   print("Error: \(error)")
               }
           }
    }

    func sendNotification(seconds: Double) {
        let notificationContent = UNMutableNotificationContent()

          notificationContent.title = "오늘의 확진자"
        notificationContent.body = "코로나 10 확진자 : \(covid19struct.NOW_DECIDE_CNT ?? "No Data"), 사망자 : \(covid19struct.NOW_DEATH_CNT ?? "No Data"), 격리해제 : \(covid19struct.NOW_CLEAR_CNT)" ?? "No Data"

          let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
          let request = UNNotificationRequest(identifier: "testNotification",
                                              content: notificationContent,
                                              trigger: trigger)

          userNotificationCenter.add(request) { error in
              if let error = error {
                  print("Notification Error: ", error)
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
        
        
        
    }
    func setSafeArea() {
        mainBackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainBackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainBackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainBackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setNavagationBar() {
        self.view.backgroundColor = .systemBackground
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let image = UIImage(named: "CoNoTitle")
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.navigationItem.rightBarButtonItem = personButton
    }
    
    
}
extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let Ccell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! UpdateDateLabelTableViewCell
            let bgColorView = UIView()
            bgColorView.backgroundColor = .clear
            Ccell.selectedBackgroundView = bgColorView
            Ccell.CovidDeviderTitleLabel.text = "\(covid19struct.updateDate ?? "데이터가 없어요")일 기준"
            return Ccell
        }
        else {
            let deshViewOffset = DeshViewOffset()
            let Ccell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DeshBoardTableViewCell
            let bgColorView = UIView()
            Ccell.DeshBoardView.backgroundColor = deshViewOffset.backColor?[indexPath.row]
            Ccell.decideDateLabel.textColor = deshViewOffset.labelColor?[indexPath.row]
            Ccell.decideDateLabel.text = "\(deshViewOffset.bodyTitle?[indexPath.row] ?? "") : \(deshViewOffset.bodyText?[indexPath.row] ?? "값이 없습니다.")"
            bgColorView.backgroundColor = .clear
            Ccell.selectedBackgroundView = bgColorView
            return Ccell
        }
    }
}
extension MainViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
}
