//
//  PhoneNumberFinder.swift
//  TheRecountSpider
//
//

import Foundation

class PhoneNumberFinder {
    static func find(text: String) -> [String] {
        do {
            var numbers: [String] = []

            let types: NSTextCheckingResult.CheckingType = .phoneNumber
            let detector = try NSDataDetector(types: types.rawValue)
            
            let range = NSRange(location: 0, length: text.count)
            let matches = detector.matches(in: text, options: [], range: range)
            for match in matches{
                if match.resultType == .phoneNumber, let number = match.phoneNumber {
                    numbers.append(number)
                }
            }
            return numbers
        }
        catch {
            print("error detecting numbers: \(error)")
            return []
        }
    }
}
