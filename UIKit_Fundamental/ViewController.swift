//
//  ViewController.swift
//  UIKit_Fundamental
//
//  Created by 김지은 on 2021/11/17.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentBtn: UISegmentedControl!
    @IBOutlet weak var myTextField: UITextField!
    
    @objc fileprivate func onSegmentBtnClicked() {
        print("ViewController - onSegmentBtnClicked() called / segmentIndex: \(segmentBtn.selectedSegmentIndex)")
        
        if (self.segmentBtn.selectedSegmentIndex == 0) {
            self.myTextField.placeholder = "사진 키워드 입력"
        }
        else if (self.segmentBtn.selectedSegmentIndex == 1) {
            self.myTextField.placeholder = "사용자 키워드 입력"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("ViewController - viewDidLoad() called")
        
        segmentBtn.addTarget(self, action: #selector(onSegmentBtnClicked), for: .touchUpInside)
    }
}

