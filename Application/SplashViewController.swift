//
//  SplashViewController.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/20/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController {
      
  private let backgroundImageView = UIImageView()
  private let logoImageView = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if AuthService.isSignedIn {
      AppController.shared.handleAuthState()
    } else {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.animateAndDismiss()
      }
    }
  }
  
  private func setupView() {
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    backgroundImageView.contentMode = .scaleAspectFill
    
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    logoImageView.contentMode = .scaleAspectFit
    logoImageView.image = AssetsService.shared.splashLogo
    
    view.addSubview(backgroundImageView)
    view.addSubview(logoImageView)
    
    NSLayoutConstraint.activate([
      backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
      backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
  
  private func animateAndDismiss() {
    let animation = CABasicAnimation(keyPath: "transform.scale")

    animation.duration = 0.3
    animation.fromValue = 1
    animation.toValue = 0

    CATransaction.begin()
    CATransaction.setCompletionBlock {
      AppController.shared.handleAuthState()
    }
    logoImageView.layer.add(animation, forKey: "scale")
    logoImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
    CATransaction.commit()
  }
  
}
