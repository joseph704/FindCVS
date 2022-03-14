//
//  LocalAPI.swift
//  FindCVS
//
//  Created by Joseph Cha on 2022/03/14.
//

import Foundation

struct LocalAPI {
    static let scheme = "https"
    static let host = "dapi.kakao.com"
    static let path = "/v2/local/search/category.json"
    
    func getLocation(by mapPoint: MTMapPoint) -> URLComponents {
        var componets = URLComponents()
        componets.scheme = LocalAPI.scheme
        componets.host = LocalAPI.host
        componets.path = LocalAPI.path
        
        componets.queryItems = [
            URLQueryItem(name: "catgory_group_code", value: "CS2"),
            URLQueryItem(name: "x", value: "\(mapPoint.mapPointGeo().longitude)"),
            URLQueryItem(name: "y", value: "\(mapPoint.mapPointGeo().latitude)"),
            URLQueryItem(name: "radius", value: "500"),
            URLQueryItem(name: "sort", value: "distance")
        ]
        
        return componets
    }
}
