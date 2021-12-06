//
//  MyApiStatusLogger.swift
//  UIKit_Fundamental
//
//  Created by 김지은 on 2021/12/06.
//

import Foundation
import Alamofire

final class MyApiStatusLogger : EventMonitor {
    
    let queue = DispatchQueue(label : "APILog")

    /*
    // request log
    func requestDidResume(_ request: Request) {
        print("MyApiStatusLogger - requestdidResume() called")
        debugPrint(request)
    }
     */
    
    // response log
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        
        guard let statusCode = request.response?.statusCode else { return }
                
        print("MyApiStatusLogger - statusCode : \(statusCode)")
        //debugPrint(response)
    }
}
