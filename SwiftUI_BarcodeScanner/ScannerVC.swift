//
//  ScannerVC.swift
//  SwiftUI_BarcodeScanner
//
//  Created by Alex 6.1 on 4/5/21.
//

import UIKit
import AVFoundation

protocol ScannerVCDelegate: class {
    func didFind(barcode: String)
}

final class ScannerVC: UIViewController {
    
    // properties
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerVCDelegate!
    
    // initializer
    init(scannerDelegate: ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // heart of the screen
    private func setupCapturreSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13]
        } else {
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
    }
    
    
}


extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    
    //delegate method
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        
        // checks if we have a metadata object in our array and grabs it
        guard let object = metadataObjects.first else { return }
        
        // checks if it's a machine readable object
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else { return }
        
        // takes the machine reable object and gets the string value out of it
        guard let barcode = machineReadableObject.stringValue else { return }
        
        // send that string value to our delegate
        scannerDelegate?.didFind(barcode: barcode)
        
    }
}
