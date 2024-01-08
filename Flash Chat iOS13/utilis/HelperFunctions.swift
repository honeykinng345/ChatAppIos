//
//  HelperFunctions.swift
//  Flash Chat iOS13
//
//  Created by Rehan on 05/01/2024.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation
import SnackBar_swift
import SystemConfiguration


 class HelperFunction {
    
    static func showSnakBar(view : UIView , message : String ){
        SnackBar.make(in: view, message: message, duration: .lengthLong).show()
    }
   static func isInternetAvailable() -> Bool {
         var zeroAddress = sockaddr_in()
         zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
         zeroAddress.sin_family = sa_family_t(AF_INET)

         guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
             $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                 SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
             }
         }) else {
             return false
         }

         var flags: SCNetworkReachabilityFlags = []
         if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
             return false
         }

         let isReachable = flags.contains(.reachable)
         let needsConnection = flags.contains(.connectionRequired)

         return isReachable && !needsConnection
     }
    static func  moveOnscreenToAnother(_ screen : UIViewController, _ route : String ){
         screen.performSegue(withIdentifier: ScreenRoutes.registerToChatScreen, sender: self)

     }
}
