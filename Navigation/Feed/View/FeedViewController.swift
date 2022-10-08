//
//  FeedViewController.swift
//  Navigation
//
//  Created by Vadim on 10.02.2022.
//


import UIKit
import SnapKit

class FeedViewController: UIViewController {
    
    // MARK: PROPERTIES
    
    private var ViewModel: FeedViewModel?
    private weak var coordinator: FeedCoordinator?
    
    private lazy var newPostButton: CustomButton = {
        let button = CustomButton (
            title: "button.newPost.title".localized,
            backImage: UIImage(named: "button_pixel") ?? UIImage()
        )
        
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowRadius = 5.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.8
        
        return button
    }()
    
    private lazy var someTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        textField.placeholder = "textField.feed.placehodler".localized
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        return textField
    }()
    
    private lazy var someButton: CustomButton = {
        let button = CustomButton (
            title: "button.send.title".localized,
            titleColor: .white,
            backImage: UIImage(named: "button_pixel") ?? UIImage()
        )
        return button
    }()
    
    private lazy var someLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: INITS
    
    init (model: FeedViewModel, coordinator: FeedCoordinator) {
        self.ViewModel = model
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apply(theme: self.interfaceStyle == .light ? .light : .dark)

        self.view.addSubviews(newPostButton, someLabel, someTextField, someButton)
        
        newPostButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.showNewPostVC()
        }
        
        someButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.someButtonAction()
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(codeRed),
            name: NSNotification.Name.codeRed,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(codeGreen),
            name: NSNotification.Name.codeGreen,
            object: nil
        )
        
        guard let ViewModel = ViewModel else { return }
        
        ViewModel.setupFeedLayout(
            newPostButton: newPostButton,
            label: someLabel,
            textField: someTextField,
            someButton: someButton
        )
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        apply(theme: self.interfaceStyle == .light ? .light : .dark)
    }
    
    // MARK: METHODS
    
    @objc func codeRed() {
        someLabel.text = "label.codeRed".localized
        someLabel.textColor = .red
    }
    
    @objc func codeGreen() {
        someLabel.text = "label.codeGreen".localized
        someLabel.textColor = .green
    }
    
    private func someButtonAction() {
        guard let ViewModel = ViewModel else { return }
        if ViewModel.check(word: someTextField.text!) == false {
            ViewModel.presentAlert(viewController: self)
        }
    }
    
    private func showNewPostVC() {
        let coordinator = NewPostCoordinator()
        coordinator.showDetail(navCon: navigationController, coordinator: coordinator)
    }
    
}

extension FeedViewController: Themeable {
    
    func apply(theme: Theme) {
        self.view.backgroundColor = theme.colors.palette.backgroud
        self.someTextField.backgroundColor = theme.colors.palette.textfield
        self.someTextField.textColor = theme.colors.palette.text
    }
}
