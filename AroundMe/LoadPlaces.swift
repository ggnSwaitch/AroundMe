//
//  LoadPlaces.swift
//  AroundMe
//
//  Created by Gagandeep Kaur Swaitch on 26/6/19.
//  Copyright © 2019 Gagandeep Kaur Swaitch. All rights reserved.
//

import Foundation
import CoreLocation

struct LoadPlaces {
    let apiURL = "https://maps.googleapis.com/maps/api/place/"
    let apiKey = "AIzaSyDekpq5GAEhFKnb30lu2gaVmufBfVog5zM"
    
    func loadPlace(location: CLLocation, radius: Int = 30, handler: @escaping (NSDictionary?, NSError?) -> Void){
        print("Load locations")
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let uri = apiURL + "nearbysearch/json?location=\(latitude),\(longitude)&radius=\(radius)&sensor=true&types=establishment&key=\(apiKey)"
        
        let url = URL(string: uri)!
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print(data!)
                    
                    do {
                        let responseObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        guard let responseDict = responseObject as? NSDictionary else {
                            return
                        }
                        
                        handler(responseDict, nil)
                        
                    } catch let error as NSError {
                        handler(nil, error)
                    }
                }
            }
        }
        
        dataTask.resume()
}
    
//    func loadDetailedInformation(forPlace: Place, handler: @escaping (NSDictionary?, NSError?) -> Void)  {
//        
//    }
    
    
}

