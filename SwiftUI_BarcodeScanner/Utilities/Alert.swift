//
//  Alert.swift
//  SwiftUI_BarcodeScanner
//
//  Created by Alex 6.1 on 4/8/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidDeviceInput = AlertItem(title: "Invalid Device Input",
                                              message: "Something is wrong with camera. We arer unable to cacpture the input.",
                                              dismissButton: .default(Text("OK")))
    
    static let invalidScannedType = AlertItem(title: "Invalid Scan Type",
                                              message: "The value scanned is not invalid. The app scans EAN-8 and EAN-13.",
                                              dismissButton: .default(Text("OK")))
}
