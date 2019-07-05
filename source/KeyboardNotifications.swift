//
//  KeyboardNotifications.swift
//  Pods-SampleStickersApp
//
//  Created by Sergey Penziy on 7/5/19.
//

enum KeyboardState {
    case showKeyboard
    case hideKeyboard
}

protocol KeyboardNotificationsProtocol {
    func set(keyboardState: KeyboardState)
}

class KeyboardNotifications: KeyboardNotificationsProtocol {
    
    private var keyboardState: KeyboardState = .hideKeyboard
    
    var animatingParameters: ((KeyboardState, CGRect, Double) -> Void)?
    
    //MARK: - Initialization and Deallocation
    
    deinit {
        self.unregisterNotifications()
    }
    
    init() {
        self.registerNotifications()
    }
    
    //MARK: - KeyboardNotificationsProtocol
    
    func set(keyboardState: KeyboardState) {
        self.keyboardState = keyboardState
    }
    
    //MARK: - Private methods
    
    private func registerNotifications() {
        let notificationCenter = NotificationCenter.default
        [UIResponder.keyboardWillShowNotification, UIResponder.keyboardWillHideNotification]
            .forEach {
                notificationCenter.addObserver(self,
                                               selector: #selector(showOrHideKeyboard),
                                               name: $0,
                                               object: nil)
        }
    }
    
    private func unregisterNotifications() {
        let notificationCenter = NotificationCenter.default
        [UIResponder.keyboardWillShowNotification, UIResponder.keyboardWillHideNotification]
            .forEach {
                notificationCenter.removeObserver(self,
                                                  name: $0,
                                                  object: nil)
        }
    }
    
    @objc private func showOrHideKeyboard(_ notification: Notification) {
        let keyboardState: KeyboardState = UIResponder.keyboardWillShowNotification == notification.name ? .showKeyboard : .hideKeyboard
        let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        self.animatingParameters?(keyboardState, keyboardState == .showKeyboard ? endFrame : CGRect.zero, duration)
        
    }
}
