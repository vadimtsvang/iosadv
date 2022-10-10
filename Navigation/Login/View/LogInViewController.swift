//
//  LogInViewController.swift
//  Navigation
//
//  Created by Vadim on 20.02.2022.
//

import UIKit
import SnapKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: PROPERTIES ======================================================================
    
   public var delegate: LoginViewControllerDelegate?

    var userService = TestUserService()
            
    private var isUserExists: Bool? {
        willSet {
            if newValue! {
                enterButton.setTitle("button.login.title".localized, for: .normal)
                variableButton.setTitle("button.switchReg.title".localized, for: .normal)

            } else {
                enterButton.setTitle("button.register.title".localized, for: .normal)
                variableButton.setTitle("button.switchLogin.title".localized, for: .normal)
            }
        }
    }
    
    private lazy var logInScrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .systemGray6
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private lazy var enterButton: CustomButton = {
        let button = CustomButton (
            titleColor: UIColor.white,
            backColor: UIColor.white,
            backImage: UIImage(named: "button_pixel") ?? UIImage()
        )
        
        button.alpha = 0.5
        button.isEnabled = false

        return button
    }()
    
    private lazy var variableButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
//        button.setTitleColor(ColorSet.mainColor, for: .normal)
        button.addTarget(self, action: #selector(switchLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var biometricsAuthorizationButton: UIButton = {
        let button = UIButton()
        
        let image = LocalAuthorizationService.shared.availableAuthorizationType == .faceID ? "faceid" : "touchid"
        
        let normalImage = UIImage(systemName: image, withConfiguration: UIImage.SymbolConfiguration(pointSize: 64))?.withTintColor(.systemGray, renderingMode: .alwaysOriginal) ?? UIImage()
        let highlightedImage = UIImage(systemName: image, withConfiguration: UIImage.SymbolConfiguration(pointSize: 64))?.withTintColor(.systemGray3, renderingMode: .alwaysOriginal) ?? UIImage()
        
        button.setImage(normalImage, for: .normal)
        button.setImage(highlightedImage, for: .highlighted)
        button.addTarget(self, action: #selector(biometricsAuthorizationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginTextField = CustomTextfield (
        customPlaceholder: "textField.login.placehodler".localized,
        secure: false,
        iconName: "person"
    )
    
    private lazy var passwordTextField = CustomTextfield (
        customPlaceholder: "textField.password.placehodler".localized,
        secure: true,
        iconName: "lock"
    )


    // MARK: INITS ======================================================================

    override func viewDidLoad() {
        super.viewDidLoad()
                        
        isUserExists = true
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
                        
        enterButton.tapAction = { [weak self] in
            guard let self = self else { return }
                self.enterButtonPressed()
            }
        
        loginTextField.textChangedAction = { [weak self] in
            guard let self = self else { return }
                self.enterButtonEnabled()
            }
        
        passwordTextField.textChangedAction = { [weak self] in
            guard let self = self else { return }
                self.enterButtonEnabled()
            }
        
        setupLayout()
        hideKeyboardWhenTappedAround()
        
    }
        
    override func viewDidAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardShow),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardHide),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }

    
    // MARK: METHODS
        
    private func enterButtonPressed() { // Закоротил авторицацию
        pushProfileViewController()
    }
    
    private func toAuthentication (_ login: String, _ password: String) {
    }


//    private func showAlertController(_ description: String) -> UIAlertController {
//        let alertController = UIAlertController(
//            title: "alertLabel.error".localized,
//            message: description,
//            preferredStyle: .alert)
//
//        let acceptAction = UIAlertAction(title: "alertButton.ok".localized, style: .default) { _ in }
//
//        alertController.addAction(acceptAction)
//        return alertController
//    }
    
 
    // MARK: LAYOUT

    private func setupLayout() {
        
        apply(theme: self.interfaceStyle == .light ? .light : .dark )
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
//        view.backgroundColor = .white
        view.addSubview(logInScrollView)
        logInScrollView.addSubview(contentView)
        contentView.addSubviews(
            logo,
            textFieldsStackView,
            enterButton,
            variableButton,
            biometricsAuthorizationButton
        )
        textFieldsStackView.addArrangedSubview(loginTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        
        logInScrollView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.centerX.centerY.equalTo(logInScrollView)
        }
        
        logo.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalTo(contentView).offset(120)
            make.centerX.equalTo(contentView)
        }
        
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(120)
            make.leading.trailing.equalTo(contentView).inset(Constants.margin)
            make.height.equalTo(100)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldsStackView.snp.bottom).offset(Constants.margin)
            make.leading.trailing.equalTo(contentView).inset(Constants.margin)
            make.height.equalTo(50)
        }
        
        variableButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(Constants.margin)
            make.top.equalTo(enterButton.snp.bottom).offset(Constants.margin / 2)
            make.height.equalTo(20)
        }
        
        biometricsAuthorizationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(variableButton.snp.bottom).offset(Constants.margin)
        }
    }
        
    //MARK: SUBMETHODS
    
    @objc
    private func switchLogin() {
        isUserExists!.toggle()
    }
    
    @objc
    private func biometricsAuthorizationButtonTapped() {
        LocalAuthorizationService.shared.authorizeIfPossible { [weak self] success, error  in
            guard let self = self else { return }
            if success {
                self.pushProfileViewController()
            } else if let error = error {
                self.showAlertController("alertmessage.biometric".localized + error.localizedDescription)
            }
        }
    }
    
    private func showAlertController(_ description: String) {
        let alertController = UIAlertController(
            title: "alertLabel.error".localized,
            message: description,
            preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: "alertButton.ok".localized, style: .default) { _ in }
        alertController.addAction(acceptAction)
        present(alertController, animated: true)
    }
    
    @objc
    private func keyboardShow(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            logInScrollView.contentOffset.y = keyboardRectangle.height - (logInScrollView.frame.height - enterButton.frame.maxY) + 16
        }
    }
    
    @objc
    private func keyboardHide(_ notification: Notification){
        logInScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    @objc
    private func enterButtonEnabled() {
        if loginTextField.text?.isEmpty == false && passwordTextField.text!.count >= 6 {
            enterButton.alpha = 1.0
            enterButton.isEnabled = true
        } else {
            enterButton.alpha = 0.5
            enterButton.isEnabled = false
        }
    }
    
    private func pushProfileViewController() {
        let coordinator = ProfileCoordinator()
        let profileViewController = coordinator.showDetail(coordinator: coordinator)
        navigationController?.pushViewController(profileViewController, animated: true)
        navigationController?.setViewControllers([profileViewController], animated: true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        apply(theme: self.interfaceStyle == .light ? .light : .dark )
    }
}

extension LogInViewController: Themeable {
    
    func apply(theme: Theme) {
        self.view.backgroundColor = theme.colors.palette.backgroud
        self.loginTextField.backgroundColor = theme.colors.palette.textfield
        self.passwordTextField.backgroundColor = theme.colors.palette.textfield
        self.loginTextField.textColor = theme.colors.palette.text
        self.passwordTextField.textColor = theme.colors.palette.text
        self.variableButton.setTitleColor(theme.colors.palette.interactiveText, for: .normal)
        
    }
}

fileprivate extension UITextField {
    private func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    private func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

