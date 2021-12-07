//
//  Constants.swift
//  UIKit_Fundamental
//
//  Created by 김지은 on 2021/11/25.
//

import Foundation

enum SEGUE_ID {
    static let USER_LIST_VC = "goToUserListVC"
    static let PHOTO_COLLECTION_VC = "goToPhotoCollectionVC"
}

enum API {
    static let BASE_URL : String = "https://api.unsplash.com/"
    static let CLIENT_ID : String = "tnnuG-fcoSbmH6PxDRRx7bAoMI37otA8NAmst13G_ds"
}

enum NOTIFICATION {
    enum API {
        static let AUTH_FAIL = "authentication_fail"
    }
}
