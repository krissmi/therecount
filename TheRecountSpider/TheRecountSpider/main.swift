//
//  main.swift
//  TheRecountSpider
//
//

import Foundation
import SwiftSoup
 
let baseUrl = URL(string: "https://therecount.github.io/interview-materials/project-a")
guard let baseUrl = baseUrl else {
    exit(1)
}
print("base url: \(url.absoluteString)")
let url = baseUrl.appendingPathComponent("1.html")
print("top url: \(url.absoluteString)")

let phoneNumbers = performSearch(url: url)

func performSearch(url: URL) -> [String] {
    var phoneNumbers: [String] = []

    let client = WebClient()
    client.request(with: url) { data in
        do {
            let html = String(data: data, encoding: .utf8) ?? ""
            let doc: Document = try SwiftSoup.parse(html)
            
            let body = try doc.text()
            phoneNumbers.append(contentsOf: PhoneNumberFinder.find(text: body))
            
            let links: Elements = try doc.select("a")
            for link in links {
                let text: String = try link.text();
                let href: String = try link.attr("href")
                print("link text: \(text) href: \(href)")
                
                if href.contains("http") {
                    if let nextUrl = URL(string: href) {
                        phoneNumbers.append(contentsOf: performSearch(url: nextUrl))
                    }
                }
                else {
                    var newPath: [String] = []
                    for pathPart in href.split(separator: "/") {
                        if !baseUrl.absoluteString.contains(pathPart) {
                            newPath.append(String(pathPart))
                        }
                    }
                    let nextUrl = baseUrl.appendingPathComponent(newPath.joined(separator: "/"))
                    phoneNumbers.append(contentsOf: performSearch(url: nextUrl))
                }
            }
        }
        catch {
            print("error parsing document: \(error)")
            exit(2)
        }
    }
    return phoneNumbers
}

exit(0)
