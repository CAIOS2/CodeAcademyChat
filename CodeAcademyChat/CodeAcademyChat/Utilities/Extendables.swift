//
//  Extendables.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-12.
//

import Foundation

extension Encodable {
    func toJSONString() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }

}
func instantiate<T: Decodable>(jsonString: String) -> T? {
    return try? JSONDecoder()
    .decode(T.self, from: jsonString.data(using: .utf8)!)
}
