//
//  Router.swift
//  Planets SLT
//
//  Created by Chathura Jayanaka on 11/14/21.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {

    static let baseURLString = "https://swapi.dev/api"
    
    case getPlanets(Int)
    
    var method: HTTPMethod {
        switch self {
        case .getPlanets:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPlanets:
            return "/planets"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case let .getPlanets(page):
                return ("/planets", ["page": page])
            default:
                return ("", [:])
            }
        }()
        
        let url = try Router.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest = try URLEncoding.default.encode(urlRequest, with: result.parameters)
        
        print(urlRequest)
        return urlRequest
    }
    
}

