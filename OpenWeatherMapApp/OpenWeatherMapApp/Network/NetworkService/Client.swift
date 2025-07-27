//
//  Client.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 27.07.2025.
//

import Foundation

//MARK: Base Response Model
struct BaseResponse: Codable {
    let status: Int
    let error: String
}

extension BaseResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}

import Foundation

class Client {
     
    // General Get Request
    @discardableResult
    private class func tasksForGETRequest<ResponseType: Codable>(url: URL, responseType: ResponseType.Type, completion: @escaping(ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let body = String(data: data, encoding: .utf8)
            debugPrint(body as! NSString)
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(BaseResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        return task
    }
    
    class func getWeatherByLatLong(lat: Double, long: Double, completion: @escaping(OpenWeather?, Error?) -> Void) {
         tasksForGETRequest(url: Endpoints.latLong(lat, long).url, responseType: OpenWeather.self) { response, error in
             if let response = response {
                 completion(response, nil)
             } else {
                 completion(nil, error)
             }
         }
     }
}

import Foundation

enum Endpoints {
    static private let baseApi = "https://api.openweathermap.org/data/2.5/weather"
    
    case latLong(Double, Double)
    
    var stringValue: String {
        switch self {
        case .latLong(let latitude, let longtitude):
            return Endpoints.baseApi + "?lat=\(latitude)&lon=\(longtitude)&appid=8ddadecc7ae4f56fee73b2b405a63659"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}


