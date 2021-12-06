//
//  MyLogger.swift
//  UIKit_Fundamental
//
//  Created by 김지은 on 2021/12/06.
//

import Foundation
import Alamofire

final class MyLogger : EventMonitor {
    let queue = DispatchQueue(label : "APILog")

    // request log
    func requestDidResume(_ request: Request) {
        print("MyLogger - requestdidResume() called")
        debugPrint(request)
    }
    
    // response log
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        print("MyLogger - request.didParseResponse() called")
        debugPrint(response)
    }
}
