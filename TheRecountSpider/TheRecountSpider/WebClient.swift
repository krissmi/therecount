//
//  Web.swift
//  TheRecountSpider
//
//

import Foundation

class WebClient {
    
    let sem = DispatchSemaphore(value: 0)
    
    @discardableResult
    func request(with endpoint: URL, _ completion: @escaping (Data) -> Void) -> URLSessionDataTask? {
        print("webclient.url: \(endpoint.absoluteString)")
        let request = URLRequest(url: endpoint)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            defer {
                self.sem.signal()
            }
            
            if let error = error {
                print("failed to fetch url: \(endpoint.absoluteString) \(error)")
                return
            }
            
            if let data = data {
                completion(data)
            }
        }
        task.resume()
        self.sem.wait()
        
        return task
    }

}
