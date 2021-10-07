//
//  Web.swift
//  TheRecountSpider
//
//  Created by Krishna Smith on 10/7/21.
//

import Foundation
import SwiftSoup

class WebClient {
    
    @discardableResult
    func request(with endpoint: URL, _ completion: @escaping (Document) -> Void) -> URLSessionDataTask? {
        
        let sem = DispatchSemaphore(value: 0)
        
        let request = URLRequest(url: endpoint)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            defer {
                sem.signal()
            }
            
            if let error = error {
                print("failed to fetch url: \(endpoint.absoluteString) \(error)")
                return
            }
            
            if let data = data {
                do {
                    let html = String(data: data, encoding: .utf8) ?? ""
                    let doc: Document = try SwiftSoup.parse(html)
                    completion(doc)
                }
                catch {
                    print("error during retrieval: \(error)")
                    return
                }
            }
        }
        task.resume()
        sem.wait()
        
        return task
    }

}
