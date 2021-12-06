//
//  MyAlamofireManager.swift
//  UIKit_Fundamental
//
//  Created by 김지은 on 2021/12/02.
//

import Foundation
import Alamofire

final class MyAlamofireManager {
    // 싱글턴 적용
    static let shared = MyAlamofireManager()
    
    // 인터셉터
    let interceptors = Interceptor(interceptors :
                        [
                            BaseInterceptor()
                        ])
    
    // 로거 설정
    let monitors = [
                        MyLogger()
                      , MyApiStatusLogger()
                   ] as [EventMonitor]
    
    // 세션 설정
    var session : Session
    
    private init() {
        session = Session(
                            interceptor : interceptors
                          , eventMonitors : monitors
                         )
    }
}
