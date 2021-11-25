//
//  BaseVC.swift
//  UIKit_Fundamental
//
//  Created by 김지은 on 2021/11/25.
//

import UIKit

class BaseVC: UIViewController {
    var vcTitle: String = "" {
        didSet {
            print("BaseVC - vcTitle didSet() called / vcTitle: \(vcTitle)")
            self.title = vcTitle
        }
    }
}
