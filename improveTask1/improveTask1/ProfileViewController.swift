//
//  PasswordViewController.swift
//  improveTask1
//
//  Created by 1234 on 25.03.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//


import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var tableViewProfile: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ProfileLoginTableViewCellNib = UINib(nibName: "ProfileLoginTableViewCell", bundle: Bundle.main)
        tableViewProfile.register(ProfileLoginTableViewCellNib, forCellReuseIdentifier: "ProfileLoginTableViewCell")
        
        let ProfilePhotoTableViewCellNib = UINib(nibName: "ProfilePhotoTableViewCell", bundle: Bundle.main)
        tableViewProfile.register(ProfilePhotoTableViewCellNib, forCellReuseIdentifier: "ProfilePhotoTableViewCell" )
        
        let ProfilePlainTableViewCellNib = UINib(nibName: "ProfilePlainTableViewCell", bundle: Bundle.main)
        tableViewProfile.register(ProfilePlainTableViewCellNib, forCellReuseIdentifier: "ProfilePlainTableViewCell" )
        
          
        tableViewProfile.tableFooterView = UIView()
        tableViewProfile.dataSource = self
        tableViewProfile.delegate = self
    }
}

extension ProfileViewController: UITableViewDelegate {
    func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UIScreen.main.bounds.height/2
        } else {
            return  48.0
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0,
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfilePhotoTableViewCell",for:indexPath) as? ProfilePhotoTableViewCell {
            cell.iconImage.image = UIImage(named: "male avatar")
            cell.loginLabel.text = "Логин пользователя"
            cell.userPhoto.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.5333333333, blue: 0.9176470588, alpha: 0.51)
            return cell
        }
        
        if indexPath.row == 1,
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfilePlainTableViewCell", for: indexPath) as? ProfilePlainTableViewCell {
            cell.dateRegistrationLabel.text = "Дата Регистрации"
            cell.dateLabel.text = "12.12.2020"
            return cell
        }
        
        if indexPath.row == 2,
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileLoginTableViewCell", for: indexPath) as? ProfileLoginTableViewCell {
            cell.colorProfileImage.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.5333333333, blue: 0.9176470588, alpha: 0.51)
            cell.colorProfileImage.layer.cornerRadius = 7
            cell.titleLabel.text = "Цвет профиля"
            return cell
        }
        return ProfileLoginTableViewCell()
    }
}


