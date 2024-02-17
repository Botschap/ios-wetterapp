//
//  DemoView.swift
//  ios-wetterapp
//
//  Created by admin on 17.02.24.
//

import Foundation
import UIKit

class DemoView : UIView {
    
    let demoText: UILabel = UILabel()
    let demoicon: UIImageView = UIImageView(image: UIImage(systemName: "sun.max.fill"))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        demoText.text = "Köln"
        demoText.backgroundColor = UIColor.white
        demoText.font = UIFont.boldSystemFont(ofSize: 25)
        addSubview(demoText)
        addSubview(demoicon)
        disableAutoresizingMaskConstraints()
        computeLayout()
    }
    
    func computeLayout() {
        let views: [String:Any] = [
            "text": demoText,
            "icon": demoicon
        ]
        let metrics: [String:Int] = [
            "s": 20,
        ]
        let constraintsAsStrings: [String] = [
            "H:|-s-[text]-(>=s)-[icon(>=60)]-(s)-|",
            "V:|-s-[icon(>=60)]-(>=s)-|",
            "V:|-s-[text(==icon)]-(>=s)-|"
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
        
    }
    
}
