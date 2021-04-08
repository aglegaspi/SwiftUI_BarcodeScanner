//
//  BarcodeScannerViewModel.swift
//  SwiftUI_BarcodeScanner
//
//  Created by Alex 6.1 on 4/8/21.
//

import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    
    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?
    
    var statusText: String {
        scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode
    }
    
    var statusTextColor: Color {
        scannedCode.isEmpty ? .red : .green
    }
}

// in the View Model you don't use State or Private
// you do Published because the Viewe Model is broadcasting its changes
// you have to set something up to listen to to those changes

