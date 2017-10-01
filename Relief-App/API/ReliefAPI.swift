//
//  ReliefAPI.swift
//  Relief-App
//
//  Created by Steven Hurtado on 10/1/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import Foundation

typealias JSONDictionary = Dictionary<String, AnyObject>
typealias JSONArray = Array<AnyObject>
typealias APICallback = ((NSDictionary?, Int, String?) -> ())

class ReliefAPI: NSObject, NSURLConnectionDataDelegate
{
    static var instance: ReliefAPI!
    class func sharedInstance() -> ReliefAPI {
        self.instance = (self.instance ?? ReliefAPI())
        return self.instance
    }
    
    //disasters within range
    func getDisastersRecent(callback: @escaping APICallback)
    {
        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .month, value: -3, to: Date())
        if let startDate = startDate
        {
            let dateFormatter = DateFormatter()

//            https://api.reliefweb.int/v1/reports?appname=apidoc&filter[field]=date.created&filter[value][from]=2004-06-01T00:00:00%2B00:00&filter[value][to]=2004-06-30T23:59:59%2B00:00
            
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
            let start = dateFormatter.string(from: startDate)
            guard let strt = start.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{return}
            let end = dateFormatter.string(from: endDate)
            guard let nd = end.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{return}
            
            let base = "https://api.reliefweb.int/v1/disasters?"
            let url = (base + "appname=apidoc&limit=20&filter[field]=date.created&filter[value][from]=\(strt)&filter[value][to]=\(nd)")
            
            var buildURL = ""
            for c in url
            {
                if c == "+"
                {
                    buildURL += "%2B"
                }
                else
                {
                    buildURL += "\(c)"
                }
            }
            
            makeHTTPRequest(url: buildURL, method: "GET", paramsString: "") { (data, status, error) in
                if(error == nil)
                {
                    callback(data, status, nil)
                }
                else{
                    callback(nil, status, error)
                }
            }
        }
    }
    
    //Training
    //https://api.reliefweb.int/v1/training?filter[field]=city&filter[value]=(City Name)
    func getTrainingCenters(city: String, callback: @escaping APICallback)
    {
        let endDate = Date()
        if let startDate = Calendar.current.date(byAdding: .month, value: -3, to: Date())
        {
            let dateFormatter = DateFormatter()
            
            let start = dateFormatter.string(from: startDate)
            let end = dateFormatter.string(from: endDate)
            
            let base = "https://api.reliefweb.int/v1/disasters?"
            let url = base + "appname=apidoc&limit=100&filter[field]=date.created&filter[value][from]=(\(start)) &filter[value][to]=(\(end))"
            
            makeHTTPRequest(url: url, method: "GET", paramsString: "") { (data, status, error) in
                if(error == nil)
                {
                    callback(data, status, nil)
                }
                else{
                    callback(nil, status, error)
                }
            }
        }
    }
    
    // MARK: - Base HTTP
    func makeHTTPRequest(url: String, method: String, paramsString: String, callback: @escaping APICallback) {
        if let urlObject = URL(string: url)
        {
            var request = URLRequest(url: urlObject)
            if (method == "POST") {
                request.httpMethod = "POST"
                request.httpBody = paramsString.data(using: String.Encoding.utf8)
            } else {
                request.httpMethod = "GET"
            }
            let _: NSError?
            
            httpRequest(request: request) {
                (data, statusCode,error) in
                callback(data, statusCode,error)
            }

        }
        else
        {
            
        }
    }
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func httpRequest(request: URLRequest, callback: @escaping APICallback) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
        
            DispatchQueue.main.async {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                if let error = error {
                    callback(nil, statusCode ?? 0, error.localizedDescription)
                } else {
                    if let data = data {
                        let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                        print(dataString ?? "")
                        do {
                            let jsonResult: Any? = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers)
                            if let nsDictionaryObject = jsonResult as? NSDictionary {
                                if (jsonResult != nil) {
                                    callback(nsDictionaryObject, statusCode ?? 0, nil)
                                }else{
                                    callback(nil, statusCode ?? 0, nil)
                                }
                            }
                        } catch let error2 as NSError {
                            
                            callback(nil, statusCode ?? 0, error2.localizedDescription)
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
