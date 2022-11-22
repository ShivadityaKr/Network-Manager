//
//  NetworkManager.swift
//  NetworkCheck
//
//  Created by Shivaditya Kumar on 2022-11-22.
//

import Foundation

class NetworkManager {
    static var shared = NetworkManager()
    var connectionActive: Observable<Bool?> = Observable(nil)
    var wifiActive: Observable<Bool?> = Observable(nil)
    var mobileDataActive: Observable<Bool?> = Observable(nil)
    var networkStatus: Observable<Network.Status?> = Observable(nil)
    private init() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
        updateNetworkStatus()
    }
    func updateNetworkStatus() {
        self.networkStatus.value = Network.reachability.status
        switch Network.reachability.status {
        case .unreachable:
            self.connectionActive.value = false
            self.mobileDataActive.value = false
            self.wifiActive.value = false
        case .wwan:
            self.connectionActive.value = true
            self.mobileDataActive.value = true
        case .wifi:
            self.connectionActive.value = true
            self.wifiActive.value = true
        }
    }
    @objc func statusManager(_ notification: Notification) {
        updateNetworkStatus()
    }
}

