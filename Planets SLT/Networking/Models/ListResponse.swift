//
//  ListResponse.swift
//  Planets SLT
//
//  Created by Chathura Jayanaka on 11/14/21.
//

import ObjectMapper

struct ListResponse<T: Mappable>: Mappable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [T]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        count <- map["count"]
        next <- map["next"]
        previous <- map["previous"]
        results <- map["results"]
    }
}
