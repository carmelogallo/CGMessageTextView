//
//  ViewController.swift
//  CGMessageTextView
//
//  Created by carmelo.g@asasasoftware.com on 06/19/2017.
//  Copyright (c) 2017 carmelo.g@asasasoftware.com. All rights reserved.
//

import UIKit
import CGMessageTextView

class ViewController: UIViewController {

    // MARK: - UI Properties
    private let messageTextView = CGMessageTextView()

    // MARK: - Logic Properties
    fileprivate var heightContraint: NSLayoutConstraint?

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        setupConstraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageTextView.becomeFirstResponder()
    }
    
    // MARK: - Setup Methods
    private func setupComponents() {
        // self
        automaticallyAdjustsScrollViewInsets = false
        
        // messageTextView
        messageTextView.messageTextViewDelegate = self
        messageTextView.placeholderText = "Write something..."
        messageTextView.layer.borderWidth = 1.0
        messageTextView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(messageTextView)
    }
    
    private func setupConstraints() {
        // messageTextView
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: messageTextView,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .top,
                                              multiplier: 1.0,
                                              constant: 100.0))
        view.addConstraint(NSLayoutConstraint(item: messageTextView,
                                              attribute: .left,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .left,
                                              multiplier: 1.0,
                                              constant: 25.0))
        view.addConstraint(NSLayoutConstraint(item: messageTextView,
                                              attribute: .right,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .right,
                                              multiplier: 1.0,
                                              constant: -25.0))
        heightContraint = NSLayoutConstraint(item: messageTextView,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .notAnAttribute,
                                              multiplier: 1.0,
                                              constant: 35.0)
        guard let heightContraint = heightContraint else { return }
        view.addConstraint(heightContraint)
    }
}

// MARK: - CGMessageTextViewDelegate
extension ViewController: CGMessageTextViewDelegate {
    
    func contentSizeHeightDidChange(withHeight height: CGFloat) {
        guard let heightContraint = heightContraint, heightContraint.constant != height  else { return }
        heightContraint.constant = height
        view.setNeedsLayout()
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
}
