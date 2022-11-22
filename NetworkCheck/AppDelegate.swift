//
//  AppDelegate.swift
//  NetworkCheck
//
//  Created by Shivaditya Kumar on 2022-11-22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.reachability()
        return true
    }
}
extension AppDelegate {
    func reachability() {
        do {
            try Network.reachability = AppReachability(hostname: "www.google.com")
            _ = NetworkManager.shared
        } catch {
            switch error as? Network.Error {
            case let .failedToCreateWith(hostname)?:
                debugPrint("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                debugPrint("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                debugPrint("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                debugPrint("Network error:\nFailed to set DispatchQueue")
            case .none:
                debugPrint(error)
            }
        }
    }
}
