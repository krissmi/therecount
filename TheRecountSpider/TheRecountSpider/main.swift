//
//  main.swift
//  TheRecountSpider
//
//  Created by Krishna Smith on 10/7/21.
//

import Foundation
 
let urlStr = "https://therecount.github.io/interview-materials/project-a/1.html"
guard let url = URL(string: urlStr) else {
    exit(1)
}

let client = WebClient()
client.request(with: url) { doc in
    do {
        print("doc: \(try doc.text())")
    }
    catch {
        print("error parsing document: \(error)")
        exit(2)
    }
}

exit(0)
