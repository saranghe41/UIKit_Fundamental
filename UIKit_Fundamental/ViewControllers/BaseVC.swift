//
//  BaseVC.swift
//  UIKit_Fundamental
//
//  Created by 김지은 on 2021/11/25.
//

import UIKit
import Toast_Swift

class BaseVC: UIViewController {
    var vcTitle: String = "" {
        didSet {
            print("BaseVC - vcTitle didSet() called / vcTitle: \(vcTitle)")
            self.title = vcTitle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //print("BaseVC - viewWillAppear() called")
        
        // 인증 실패 노티피케이션 등록
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorPopup(notification:)), name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 인증 실패 노티피케이션 등록 해제
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil)
    }
    
    //MARK: - objc methods
    @objc func showErrorPopup(notification: NSNotification) {
        print("BaseVC - showErrorPopup() called")
        
        if let data = notification.userInfo?["statusCode"] {
            print("showEroorPopup() data : \(data)")
            
            // 메인쓰레드에서 돌리기 (즉, UI thread)
            DispatchQueue.main.async {
                self.view.makeToast("👻 \(data) 에러입니다.", duration: 1.5, position: .center)
            }
        }
    }
}
