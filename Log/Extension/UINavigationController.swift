//
//  UINavigationController.swift
//  Log
//
//  Created by AzumaSato on 2020/12/07.
//

import Foundation
import UIKit

// NavigationBar を非表示にした場合, スワイプで戻ることができないのでその対応
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
