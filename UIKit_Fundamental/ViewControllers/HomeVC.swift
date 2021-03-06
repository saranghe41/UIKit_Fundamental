//
//  ViewController.swift
//  UIKit_Fundamental
//
//  Created by 김지은 on 2021/11/17.
//

import UIKit
import Toast_Swift
import Alamofire

class HomeVC: BaseVC, UISearchBarDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mySegmentBtn: UISegmentedControl!
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var mySearchBtn: UIButton!
    @IBOutlet weak var myIndicator: UIActivityIndicatorView!
    var keyboardDismissTabGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
    var distance: Double = 0
    
    // MARK: - overrid methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("HomeVC - viewDidLoad() called")
        
        self.config()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("HomeVC - viewDidAppear() called")
        
        // 포커싱 주기
        self.mySearchBar.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("HomeVC - prepare() called / segue.identifier: \(segue.identifier)")
        
        switch segue.identifier {
        case SEGUE_ID.PHOTO_COLLECTION_VC:
            // 사진검색 화면의 VC를 가져온다.
            let nextVC = segue.destination as! PhotoCollectionVC
            guard let userInputValue = self.mySearchBar.text else { return }
            nextVC.vcTitle = userInputValue + "📷"
        case SEGUE_ID.USER_LIST_VC: // 사용자검색
            // 사용자검색 화면의 VC를 가져온다.
            let nextVC = segue.destination as! UserListVC
            guard let userInputValue = self.mySearchBar.text else { return }
            nextVC.vcTitle = userInputValue + "🙋🏻‍♀️"
        default:
            print("default")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HomeVC - viewWillAppear() called")
        // 키보드 올라가는 이벤트를 받는 처리
        // 키보드 노티 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowHandle(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideHandle), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("HomeVC - viewWillDisappear() called")
        // 키보드 노티 해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    // MARK: - fileprivate methods
    fileprivate func config() {
        // ui 설정
        self.mySearchBtn.layer.cornerRadius = 10
        // self.mySearchBar.searchBarStyle = .minimal // ui에서 직접설정함
        self.mySearchBtn.isHidden = true
        self.mySearchBar.delegate = self
        self.keyboardDismissTabGesture.delegate = self
        
        // 제스처 추가하기
        self.view.addGestureRecognizer(keyboardDismissTabGesture)
    }
    
    fileprivate func pushVC() {
        print("HomeVC - pushVC() called")
        
        var segueId : String = ""
        
        switch mySegmentBtn.selectedSegmentIndex
        {
            case 0:
                print("사진 화면으로 이동")
                segueId = "goToPhotoCollectionVC"
            case 1:
                print("사용자 화면으로 이동")
                segueId = "goToUserListVC"
            default:
                print("default")
        }
        
        // 화면이동
        self.performSegue(withIdentifier: segueId, sender: self)
    }
    
    @objc func keyboardWillShowHandle(notification: NSNotification) {
        print("HomeVC - keyboardWillShowHandle() called")
        // 키보드 사이즈 가져오기
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            print("keyboardSize.height: \(keyboardSize.height)")
            print("mySearchBtn.frame.origin.y: \(mySearchBtn.frame.origin.y)")
            
            if (keyboardSize.height <= mySearchBtn.frame.origin.y) {
                distance = keyboardSize.height - mySearchBtn.frame.origin.y
                print("keyboard covered searchbtn / distance: \(distance)")
                print("changed upvalue: \(distance - mySearchBtn.frame.height)")

                self.view.frame.origin.y = distance - mySearchBtn.frame.height
            }
        }
    }
    
    @objc func keyboardWillHideHandle() {
        print("HomeVC - keyboardWillHideHandle() called")
        self.view.frame.origin.y = 0
    }
    
    // MARK: - IBActions methods
    @IBAction func mySegmentBtnValueChanged(_ sender: UISegmentedControl) {
        print("HomeVC - searchFilterValueChanged() called")
        
        var searchBarTitle = ""
        
        switch sender.selectedSegmentIndex {
            case 0:
                searchBarTitle = "사진 키워드 입력"
            case 1:
                searchBarTitle = "사용자 키워드 입력"
            default:
                searchBarTitle = "사진 키워드 입력"
        }
       
        self.mySearchBar.placeholder = searchBarTitle
        // becomFirstResponder : 포커싱을 주는 함수
        // resignFirstResponder : 포커싱 해제하는 함수
        self.mySearchBar.becomeFirstResponder()
    }
    
    // 검색버튼이 클릭되었을 때
    @IBAction func onSearchBtnClicked(_ sender: UIButton) {
        print("HomeVC - onSearchBtnClicked() called / selectedIndex: \(mySegmentBtn.selectedSegmentIndex)")
    
//        let url = API.BASE_URL + "search/photos"
        guard let userInput = mySearchBar.text else { return }
//        let queryParam = ["query" : userInput, "client_id" : API.CLIENT_ID]
        
        /*
        AF.request(url, method: .get, parameters: queryParam).responseJSON(completionHandler: {
            response in debugPrint(response)
        })
         */
        
        var urlToCall : URLRequestConvertible?
        
        switch mySegmentBtn.selectedSegmentIndex {
        case 0:
           //urlToCall = MySearchRouter.searchPhotos(term: userInput)
            
            /*
             - 클로저 ARC(Automatic Reference Count)
             - 자동 메모리사용수 계산
             - stack, heap 메모리 영역
             - class, closure 등이 사용
             - self 사용시, weak self를 사용
               self는 메모리 카운트를 증가
               다음과 같이 self.메소드등 self를 사용해야 하는경우 weak self로 메모리에 계속 잡아두고 있는 현상을 방지한다.
             */
            MyAlamofireManager.shared.getPhotos(searchTerm: userInput, completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let fetchedPhotoes):
                    print("HomeVC - getPhotos.success - fetchedPhotoes.count : \(fetchedPhotoes.count)")
                case .failure(let error):
                    print("HomeVC - getPhotos.failure - error : \(error.rawValue)")
                    self.view.makeToast(error.rawValue, duration: 1.0, position: .center)
                }
            })
        case 1:
            urlToCall = MySearchRouter.searchUsers(term: userInput)
        default:
            print("default")
        }
        
//        if let urlConvertible = urlToCall {
//            MyAlamofireManager
//                .shared
//                .session
//                .request(urlConvertible)
//                .validate(statusCode: 200..<401)
//                .responseJSON(completionHandler: {
//                response in
//                    print("HomeVC - response : \(response)")
//                    print("HomeVC - response.error : \(response.error)")
//                //debugPrint(response)
//            })
//        }
        
        // 화면으로 이동
        //pushVC()
    }
    
    // MARK: - UISearchBar Delegate methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("HomeVC - searchBar textDidChage() searchText: \(searchText)")

        // 사용자가 입력한 값이 없을때
        if searchText.isEmpty {
            self.mySearchBtn.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                // 포커싱 해제
                self.mySearchBar.resignFirstResponder()
            })
        }
        else {
            self.mySearchBtn.isHidden = false
        }
    }
    
    // 글자가 입력될때
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("HomeVC - searchBar shouldChangeTextIn() shouldChangeTextIn: \(searchBar.text?.appending(text).count)")
        
        let inputTextCnt = searchBar.text?.appending(text).count ?? 0
        
        if inputTextCnt >= 12 {
            print("!!!12글자이상입력!!!")
            self.view.makeToast("📣 12자까지 입력가능합니다.", duration: 1.0, position: .center)
        }
        
//        if inputTextCnt <= 12 {
//            return true
//        }
//        else {
//            return false
//        }
        
        // 위 주석과 같음
        return inputTextCnt <= 12
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("HomeVC - searchBarSearchButtonClicked() called")
        
        guard let userInputText = searchBar.text else { return }
        
        if userInputText.isEmpty {
            self.view.makeToast("📣 검색 키워드를 입력해주세요.", duration: 1.0, position: .center)
        }
        else {
            // 화면 이동
            pushVC()
            searchBar.resignFirstResponder()
        }
    }
    
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("HomeVC - gestureRecognizer shouldReceive() called")
        
        if touch.view?.isDescendant(of: mySegmentBtn) == true {
            print("seguement touched!")
            return false
        }
        else if touch.view?.isDescendant(of: mySearchBar) == true {
            print("searchBar touched!")
            return false
        }
        else {
            view.endEditing(true)
            return true
        }
    }
}

