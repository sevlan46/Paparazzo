import AVFoundation

protocol CameraInteractor: class {
    
    func getOutputParameters(completion: CameraOutputParameters? -> ())
    func setCameraOutputNeeded(isCameraOutputNeeded: Bool)
    
    func isFlashAvailable(completion: Bool -> ())
    func setFlashEnabled(enabled: Bool, completion: (success: Bool) -> ())
    
    func canToggleCamera(completion: Bool -> ())
    func toggleCamera(completion: (newOutputOrientation: ExifOrientation) -> ())
    
    func takePhoto(completion: MediaPickerItem? -> ())
    
    func setPreviewImagesSizeForNewPhotos(size: CGSize)
}

struct CameraOutputParameters {
    let captureSession: AVCaptureSession
    var orientation: ExifOrientation
}