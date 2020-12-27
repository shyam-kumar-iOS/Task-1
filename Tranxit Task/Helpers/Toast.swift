//
//  Toast.swift
//  Pyramidion Task
//
//  Created by Shyam Kumar on 9/24/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
   
    func showToast(message : String, font: UIFont) {

     let toastLabel = UILabel()
      
    toastLabel.numberOfLines = 0
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
      
    toastLabel.translatesAutoresizingMaskIntoConstraints = false
    toastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    toastLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    toastLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
        UIView.animate(withDuration: 3.5, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })

}
}
