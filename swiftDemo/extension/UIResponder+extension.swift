//
//  UIResponder+extension.swift
//  swiftDemo
//
//  Created by Dmitry P on 17.03.24.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
