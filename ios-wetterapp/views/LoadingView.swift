//
//  LoadingView.swift
//  ios-wetterapp
//
//  Created by admin on 17.02.24.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    let loadingSpinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override func layoutSubviews() {
        loadingSpinner.color = UIColor.gray
        addSubview(loadingSpinner)
        loadingSpinner.startAnimating()
        disableAutoresizingMaskConstraints()
        NSLayoutConstraint.activate([
            loadingSpinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
