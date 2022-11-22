//
//  Observable.swift
//  NetworkCheck
//
//  Created by Shivaditya Kumar on 2022-11-22.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            for item in self.listener {
                item?(value)
            }
        }
    }
    private var listener: [((T) -> Void)?] = []

    init(_ value: T) {
        self.value = value
    }
    func bind(_ closure: @escaping (T) -> Void) {
        listener.append(closure)
    }
}

protocol ObservableUIVC : AnyObject {
    func setupUI()
}
protocol ObservableVM : AnyObject {
    var error : Observable<Error?> { get }
}
