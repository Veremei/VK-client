//
//  SettingsViewController.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/11/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit
import WebKit
import Kingfisher

final class SettingsViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        AuthService.signOut()
    }
    
    let dataProvider = SettingsDataProvider()
    var fetched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !fetched {
            fetched = true
            requestData()
        }
    }
    
    func setupUI() {
        userImageView.layer.cornerRadius = view.bounds.height * 0.15 // why not = image.height/2?image.height=image.width=view.height * 0.3,depends on aspect ratio, bad on 5s,7
        userImageView.clipsToBounds = true
        
        logoutButton.layer.cornerRadius = 4
        logoutButton.clipsToBounds = true
    }
    
    func requestData() {
        dataProvider.getData { [weak self] (response, error) in
            
            guard let self = self else { return }
            guard error == nil, let name = response?.firstName, let lastName = response?.lastName, let imageUrlString = response?.photo else {
                self.showErrorAlert(message: error?.localizedDescription ?? "Unkwnown error")
                return }
            self.nameLabel.text = "\(name) \(lastName)"
            
            guard let imageURL = URL(string: imageUrlString) else { return }
            self.userImageView.kf.setImage(with: imageURL)
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = ErrorAlertController(withTitle: "Warning", message: message, actionTitle: "OK")
        present(alert, animated: true, completion: nil)
    }
    
}
