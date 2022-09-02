//
//  Sample.swift
//  SeSAC2Week9
//
//  Created by J on 2022/09/01.
//

import Foundation

class User<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
//            print("name changed: \(oldValue) -> \(name)")
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ completionHandler: @escaping (T) -> Void ) {
        completionHandler(value)
        listener = completionHandler
    }
}
