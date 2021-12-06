//
//  MySearchRouter.swift
//  UIKit_Fundamental
//
//  Created by 김지은 on 2021/12/06.
//

import Foundation
import Alamofire

// 검색관련 API 호출
enum Router: URLRequestConvertible {
    //case get([String: String]), post([String: String])
    
    case searchPhotos(term: String)
    case searchUsers(term: String)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL + "search/")!
    }
    
    var method: HTTPMethod {
        
        switch self {
        case .searchPhotos, .searchUsers:
            return .get
        }
        
        // 여러가지 경우로 나뉠때의 예시
        /*
        switch self {
        case .searchPhotos:
            return .get
        case .searchUsers:
            return .post
        }
         */
    }
    
    // endpoint
    var path: String {
        switch self {
        case .searchPhotos:
            return "photos/"
        case .searchUsers:
            return "users/"
        }
    }
    
    // enum형태를 사용하기위해서는 let 변수로 받아야함
    var parameters : [String : String] {
        switch self {
        case let .searchPhotos(term), let .searchUsers(term):
            return ["query" : term]
        }
    }
    
    // api이 발동시 실제 동작하는 부분
    func asURLRequest() throws -> URLRequest {
        // baseURL 뒤에 path(string) 붙이는 작업
        let url = baseURL.appendingPathComponent(path)
        
        print("MySearchRouter - asURLRequest() called / url : \(url)")
        
        var request = URLRequest(url: url)
        request.method = method
        
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        
//        switch self {
//        case let .get(parameters):
//            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
//        case let .post(parameters):
//            request = try JSONParameterEncoder().encode(parameters, into: request)
//        }
        
        return request
    }
}
