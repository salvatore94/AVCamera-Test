//
//  ViewController.swift
//  AVCamera-test
//
//  Created by Salvatore  Polito on 08/02/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

//    var captureSession : AVCaptureSession?
    var backCamera : AVCaptureDevice?
    var frontCamera : AVCaptureDevice?
    
    var captureInput : AVCaptureInput?
    @IBOutlet weak var button: UIButton!
    
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareDevices()
        if (backCamera != nil) {
            do { try captureInput = AVCaptureDeviceInput.init(device: backCamera)
                
            } catch  {
                print("capturinput = backcamera")
            }
            
        }else if (frontCamera != nil) {
            do { try captureInput = AVCaptureDeviceInput.init(device: frontCamera)
                
            } catch  {
                print("capturinput = frontcamera")
            }
        }
        let captureSession = AVCaptureSession()
        if (captureSession.canAddInput(captureInput)) {
            captureSession.addInput(captureInput)
            captureSession.startRunning()
            previewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
            previewLayer.frame = view.bounds
            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            view.layer.addSublayer(previewLayer)
            view.addSubview(button)
        }
        
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
   
    }
    
    

    
    func prepareDevices () {
        
        let deviceDiscoverySession = AVCaptureDeviceDiscoverySession.init(deviceTypes: [AVCaptureDeviceType.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: .unspecified)
        for device in (deviceDiscoverySession?.devices)! {
            if device.position == .back {
                backCamera = device
            } else if device.position == .front {
                frontCamera = device
            }
    }
}

    
    @IBAction func takePhoto(_ sender: Any) {
    }
    
}
