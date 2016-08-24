import AVFoundation

final class CameraPresenter: CameraModuleInput {
    
    private let interactor: CameraInteractor
    
    weak var view: CameraViewInput? {
        didSet {
            setUpView()
        }
    }
    
    // MARK: - Init
    
    init(interactor: CameraInteractor) {
        self.interactor = interactor
    }
    
    // MARK: - CameraModuleInput
    
    func getOutputParameters(completion: CameraOutputParameters? -> ()) {
        interactor.getOutputParameters(completion)
    }
    
    func setCameraOutputNeeded(isCameraOutputNeeded: Bool) {
        interactor.setCameraOutputNeeded(isCameraOutputNeeded)
    }
    
    func isFlashAvailable(completion: Bool -> ()) {
        interactor.isFlashAvailable(completion)
    }
    
    func setFlashEnabled(enabled: Bool, completion: (success: Bool) -> ()) {
        interactor.setFlashEnabled(enabled, completion: completion)
    }
    
    func canToggleCamera(completion: Bool -> ()) {
        interactor.canToggleCamera(completion)
    }
    
    func toggleCamera(completion: (newOutputOrientation: ExifOrientation) -> ()) {
        interactor.toggleCamera { [weak self] newOutputOrientation in
            self?.view?.setOutputOrientation(newOutputOrientation)
            completion(newOutputOrientation: newOutputOrientation)
        }
    }
    
    func takePhoto(completion: MediaPickerItem? -> ()) {
        interactor.takePhoto(completion)
    }
    
    func setPreviewImagesSizeForNewPhotos(size: CGSize) {
        interactor.setPreviewImagesSizeForNewPhotos(size)
    }
    
    // MARK: - Private
    
    private func setUpView() {
        
        view?.setAccessDeniedTitle("Чтобы фотографировать товар")
        view?.setAccessDeniedMessage("Разрешите камере делать фото с помощью приложения Avito")
        view?.setAccessDeniedButtonTitle("Разрешить доступ к камере")
        
        view?.onAccessDeniedButtonTap = { [weak self] in
            if let url = NSURL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        
        interactor.getOutputParameters { [weak self] parameters in
            if let parameters = parameters {
                self?.view?.setOutputParameters(parameters)
            } else {
                self?.view?.setAccessDeniedViewVisible(true)
            }
        }
    }
}
