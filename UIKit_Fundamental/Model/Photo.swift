//
//  Photo.swift
//  UIKit_Fundamental
//
//  Created by 김지은 on 2021/12/09.
//

import Foundation

struct Photo : Codable {
    var thumbNail : String
    var userName : String
    var likesCount : Int
    var createdAt : String
}
