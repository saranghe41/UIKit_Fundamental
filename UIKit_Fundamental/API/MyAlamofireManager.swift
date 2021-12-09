//
//  MyAlamofireManager.swift
//  UIKit_Fundamental
//
//  Created by 김지은 on 2021/12/02.
//

import Foundation
import Alamofire
import SwiftyJSON

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
    
    func getPhotos(searchTerm userInput : String, completion : @escaping (Result<[Photo], MyError>) -> Void) {
        print("MyAlamofireManager - getPhotos() called / userInput : \(userInput)")
        
        self.session
            .request(MySearchRouter.searchPhotos(term: userInput))
            .validate(statusCode: 200..<401)
            .responseJSON(completionHandler: {
            response in
                
                guard let responsValue = response.value else { return }
                let responseJson = JSON(responsValue)
                let jsonArray = responseJson["results"]
                var photos = [Photo]()
                
                print("jsonArray.count : \(jsonArray.count)")
                
                for (index, subJson) : (String, JSON) in jsonArray {
                    print("index : \(index), subJson : \(subJson)")
                    
                    // 데이터 파싱
                    /*
                    let tumbnail = subJson["urls"]["thumb"].string ?? ""
                    let username = subJson["user"]["username"].string ?? ""
                    let likescount = subJson["likes"].intValue ?? 0
                    let createdat = subJson["created_at"].string ?? ""
                    */
                    guard let thumbnail = subJson["urls"]["thumb"].string,
                          let username = subJson["user"]["username"].string,
                          let createdat = subJson["created_at"].string else { return }
                    let likescount = subJson["likes"].intValue
                    
                    // photos 배열에 데이터를 넣고
                    let photoItem = Photo(thumbNail: thumbnail, userName: username, likesCount: likescount, createdAt: createdat)
                    photos.append(photoItem)
                }
            if photos.count > 0 {
                completion(.success(photos))
            } else {
                completion(.failure(.noContent))
            }
        })
    }
}
