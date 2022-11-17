//
//  Random.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-17.
//

import Foundation

class Random {
    static func string(length: Int) -> String {
        let letters = "aFGQRSTUVWhijklsByN5M23bcdefEnotuHIJgPvwx9678CDKLmYZ01zAOX4pqr"
        return String((0..<length).map{ _ in letters.randomElement()! })
      }
}
