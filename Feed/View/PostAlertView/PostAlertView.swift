//
//  PostAlertView.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/14/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit

protocol PostAlertDelegate : class {
    func postButtonTapped(message: String)
}

class PostAlertView: UIView {
    
    @IBOutlet var alertView: UIView!
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBAction func dismissButtonTapped(_ sender: UIBarButtonItem) {
        messageTextView.resignFirstResponder()
        removeFromSuperview()
    }
    
    @IBAction func postButtonTapped(_ sender: UIBarButtonItem) {
        messageTextView.resignFirstResponder()
        delegate?.postButtonTapped(message: messageTextView.text)
    }
    
    weak var delegate: PostAlertDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupView() {
        Bundle.main.loadNibNamed(String(describing: PostAlertView.self), owner: self, options: nil)
        alertView.fixInView(self)
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        messageTextView.becomeFirstResponder()
    }
    
}

extension UIView {
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);        
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
