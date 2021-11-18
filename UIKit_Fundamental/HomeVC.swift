//
//  ViewController.swift
//  UIKit_Fundamental
//
//  Created by 김지은 on 2021/11/17.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var mySegmentBtn: UISegmentedControl!
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var mySearchBtn: UIButton!
    @IBOutlet weak var myIndicator: UIActivityIndicatorView!
    
    // MARK: - overrid methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("HomeVC - viewDidLoad() called")
        
        // ui 설정
        self.mySearchBtn.layer.cornerRadius = 10
        // self.mySearchBar.searchBarStyle = .minimal // ui에서 직접설정함
       
    }
    
    // MARK: - IBActions methods
    @IBAction func mySegmentBtnValueChanged(_ sender: UISegmentedControl) {
        print("HomeVC - searchFilterValueChanged() called")
        
        var searchBarTitle = ""
        
        switch sender.selectedSegmentIndex {
            case 0:
                searchBarTitle = "사진 키워드 입력"
                break
            case 1:
                searchBarTitle = "사용자 키워드 입력"
                break
            default:
                searchBarTitle = "사진 키워드 입력"
        }
       
        self.mySearchBar.placeholder = searchBarTitle
        // becomFirstResponder : 포커싱을 주는 함수
        // resignFirstResponder : 포커싱 해제하는 함수
        self.mySearchBar.becomeFirstResponder()
    }
    
    @IBAction func onSearchBtnClicked(_ sender: UIButton) {
        print("HomeVC - onSearchBtnClicked() called")
        
        var segueId : String = ""
        
        switch mySegmentBtn.selectedSegmentIndex
        {
            case 0:
                print("사진 화면으로 이동")
                segueId = "goToPhotoCollectionVC"
                break
            case 1:
                print("사용자 화면으로 이동")
                segueId = "goToUserListVC"
                break
            default:
                print("default")
                break
        }
        
        // 화면이동
        self.performSegue(withIdentifier: segueId, sender: self)
    }
}

