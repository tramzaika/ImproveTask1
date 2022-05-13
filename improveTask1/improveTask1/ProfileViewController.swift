//
//  PasswordViewController.swift
//  improveTask1
//
//  Created by 1234 on 25.03.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//


import UIKit
import KeychainSwift


class ProfileViewController: UIViewController {
    
    @IBOutlet var tableViewProfile: UITableView!
    
    let keychain = KeychainSwift()
    let autorizeSimulator = AuthorizationMockSimulator()
    var login = String()
    var userPhoto = UIImage(named: "male avatar")
    let placeholderUserPhoto = UIImage(named: "male avatar")
    var autorizationToken = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ProfileLoginTableViewCellNib = UINib(nibName: ProfileLoginTableViewCell.nibName(), bundle: Bundle.main)
        tableViewProfile.register(ProfileLoginTableViewCellNib, forCellReuseIdentifier: ProfileLoginTableViewCell.nibName())
        
        let ProfilePhotoTableViewCellNib = UINib(nibName: ProfilePhotoTableViewCell.nibName(), bundle: Bundle.main)
        tableViewProfile.register(ProfilePhotoTableViewCellNib, forCellReuseIdentifier: ProfilePhotoTableViewCell.nibName() )
        
        let ProfilePlainTableViewCellNib = UINib(nibName: ProfilePlainTableViewCell.nibName(), bundle: Bundle.main)
        tableViewProfile.register(ProfilePlainTableViewCellNib, forCellReuseIdentifier: ProfilePlainTableViewCell.nibName())
        
        tableViewProfile.tableFooterView = UIView()
        tableViewProfile.dataSource = self
        tableViewProfile.delegate = self
        
        if let token = keychain.get(UserAutorizationConstants.keychainTokenKey) {
            autorizationToken = token
        } else {
            return
        }
        
        guard let user = AuthorizationMockSimulator().getProfile(token: autorizationToken) else { return }
        
        login = user.user?.login ?? "Логин пользователя"
        if let photo = user.user?.photo {
            userPhoto = base64ToImage(photo) ?? placeholderUserPhoto
        }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let actionSheet = UIAlertController( title: nil,
                                                 message: nil,
                                                 preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default){ _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            let photo = UIAlertAction(title: "Photo", style: .default){ _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            present(actionSheet,animated: true)
        } else {
            view.endEditing(true)
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0,
           let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePhotoTableViewCell.nibName(),for:indexPath) as? ProfilePhotoTableViewCell {
            
            cell.iconImage.image = userPhoto
            cell.userPhoto.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.5333333333, blue: 0.9176470588, alpha: 0.51)
            if userPhoto != UIImage(named: "male avatar"){
                cell.userPhoto.image = userPhoto}
            cell.loginLabel.text = login
            return cell
        }
        if indexPath.row == 1,
           let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePlainTableViewCell.nibName(), for: indexPath) as? ProfilePlainTableViewCell {
            cell.dateRegistrationLabel.text = "Дата Регистрации"
            cell.dateLabel.text = "12.12.2020"
            return cell
        }
        if indexPath.row == 2,
           let cell = tableView.dequeueReusableCell(withIdentifier: ProfileLoginTableViewCell.nibName(), for: indexPath) as? ProfileLoginTableViewCell {
            cell.colorProfileImage.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.5333333333, blue: 0.9176470588, alpha: 0.51)
            cell.colorProfileImage.layer.cornerRadius = 7
            cell.titleLabel.text = "Цвет профиля"
            return cell
        }
        return ProfileLoginTableViewCell()
    }
    
    func imageToBase64(_ image: UIImage) -> String? {
        return image.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
    
    func base64ToImage(_ base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else { return nil }
        return UIImage(data: imageData)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        userPhoto = info[.editedImage] as? UIImage
        guard  let userPhoto = userPhoto else { return }
        tableViewProfile.reloadData()
        guard let photo = imageToBase64(userPhoto) else { return }
        guard let photoAnswer = autorizeSimulator.postUserImage(token: autorizationToken, base64: photo) as? AuthorizationMockSimulator.CommonAnswer else { return }
        dismiss(animated: true)
    }
}
