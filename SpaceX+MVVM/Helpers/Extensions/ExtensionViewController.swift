//
//  ExtensionViewController.swift
//  ItunesAPI
//
//  Created by Roman Korobskoy on 03.11.2021.
//

import UIKit

extension UIViewController {

    func createCustomButton(selector: Selector, image: String = "", text: String = "") -> UIBarButtonItem {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: image),for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.setTitle(text, for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }

}
