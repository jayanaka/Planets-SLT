//
//  PlanetService.swift
//  Planets SLT
//
//  Created by Chathura Jayanaka on 11/14/21.
//

import Alamofire
import AlamofireObjectMapper

class PlanetService: NSObject {

    // get all planets
    func getPlanets(page: Int, onSuccess: @escaping (String, [Planet]) -> Void, onResponseError: @escaping (String, Int) -> Void, onError: @escaping (String, Int) -> Void) {
    
        Alamofire.request(Router.getPlanets(page))
            .validate()
            .responseObject { (response: DataResponse<ListResponse<Planet>>) in
                
                switch response.result {
                case .success(let value):
                    onSuccess(value.next ?? "", value.results ?? [])
                    
                case .failure(let error):
                    print(error)
                    if response.response?.statusCode == 404 {
                        onResponseError("No internet connection ", 404)
                        break
                    } else {
                        print(error.localizedDescription)
                        onError("Sorry, Something went wrong. Please try again later.", 500)
                        break
                    }
                }
                
        }
    }
}
