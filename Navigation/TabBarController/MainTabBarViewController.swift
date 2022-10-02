//
//  AppDelegate.swift
//  Navigation
//
//  Created by Vadim on 12.05.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private let feedViewController = Factory(navigationController: UINavigationController(), state: .feed)
    private let profileViewController = Factory(navigationController: UINavigationController(), state: .profile)
    private let loginViewController = Factory(navigationController: UINavigationController(), state: .login)
    private let musicViewController = Factory(navigationController: UINavigationController(), state: .music)
//    private let videoViewController = Factory(navigationController: UINavigationController(), state: .video)
    private let favoriteViewController = Factory(navigationController: UINavigationController(), state: .favorite)
    private let locationsViewController = Factory(navigationController: UINavigationController(), state: .locations)

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor.systemGray5

        setControllers()
    }
    
    private func setControllers() {
        viewControllers = [
            profileViewController.navigationController,
            feedViewController.navigationController,
            musicViewController.navigationController,
//            videoViewController.navigationController,
            favoriteViewController.navigationController,
            locationsViewController.navigationController
        ]
    }
}
