//
//  ErrorView.swift
//  ios-wetterapp
//
//  Created by admin on 19.02.24.
//

import Foundation
import UIKit

class ErrorView: UIView {

    
    private let errorLabel: UILabel = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    
    private func setupViews() {
        errorLabel.font = UIFont.boldSystemFont(ofSize: 18)
        errorLabel.textColor = UIColor.systemRed
        errorLabel.textAlignment = NSTextAlignment.center
        addSubview(errorLabel)
        
        disableAutoresizingMaskConstraints()

        errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    
    func displayError(_ message: String) {
        errorLabel.text = message
    }
}

