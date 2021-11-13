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

class MainViewController: UIViewController {
    
    let mainBackView = UIView().then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let personButton = UIBarButtonItem().then {
        let personImage = UIImage(systemName: "person.circle")
        $0.image = personImage
        $0.tintColor = .label
    }
    let DeshBoardView = UIView().then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor.gray.cgColor
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowRadius = 20
        $0.layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    let CovidDeviderTitleLabel = UILabel().then {
        $0.text = "2021-11-15 기준"
        $0.font = UIFont(name: "ABeeZee-Regular", size: 20.0)
        $0.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(mainBackView)
        mainBackView.addSubview(DeshBoardView)
        mainBackView.addSubview(CovidDeviderTitleLabel)
        setNavagationBar()
        setConstraint()
        dateGet()
        setSafeArea()
    }
    
    func setConstraint() {
        DeshBoardView.snp.makeConstraints {
            $0.top.equalTo(60)
            $0.height.equalTo(250)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
        }
        CovidDeviderTitleLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
            $0.height.equalTo(22)
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
