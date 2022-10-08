//
//  Factory.swift
//  Navigation
//
//  Created by Vadim on 25.04.2022.
//

import UIKit

final class Factory {
    
    enum State {
        case feed
        case profile
        case login
        case music
        case video
        case favorite
        case locations
    }

    let navigationController: UINavigationController
    let state: State
    
    init(
        navigationController: UINavigationController,
        state: State
    ) {
        self.navigationController = navigationController
        self.state = state
        startModule()
    }
    
    func startModule() {
        switch state {
        case .feed:
            let coordinator = FeedCoordinator()
            let feedViewController = coordinator.showDetail(coordinator: coordinator)

            navigationController.setViewControllers([feedViewController], animated: true)
            navigationController.navigationBar.barTintColor = UIColor.systemGray5
            navigationController.navigationBar.standardAppearance = Constants.navigationBarAppearance
            navigationController.tabBarItem.setTitleTextAttributes(Constants.attributes,for: .normal)
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
            navigationController.tabBarItem = UITabBarItem(
                title: "feed.title".localized,
                image: UIImage(systemName: "list.bullet.circle"),
                selectedImage: UIImage(systemName: "list.bullet.circle.fill")
            )

        case .profile:
            let coordinator = ProfileCoordinator()
            let profileViewController = coordinator.showDetail(coordinator: coordinator)

            navigationController.setViewControllers([profileViewController], animated: true)
            navigationController.navigationBar.barTintColor = UIColor.systemGray5
            navigationController.navigationBar.standardAppearance = Constants.navigationBarAppearance
            navigationController.tabBarItem.setTitleTextAttributes(Constants.attributes, for: .normal)
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
            navigationController.tabBarItem = UITabBarItem(
                title: "profile.title".localized,
                image: UIImage(systemName: "person.circle"),
                selectedImage: UIImage(systemName:"person.circle.fill")
            )
            
        case .login:
            let coordinator = LoginCoordinator()
            let loginViewController = coordinator.showDetail(coordinator: coordinator)

            navigationController.setViewControllers([loginViewController], animated: true)
            navigationController.tabBarItem = UITabBarItem(
                title: "profile.title".localized,
                        image: UIImage(systemName: "person.circle"),
                        selectedImage: UIImage(systemName:"person.circle.fill")
                    )
        case .music:
            let coordinator = MusicCoordinator()
            let musicViewController = coordinator.showDetail(coordinator: coordinator)

            navigationController.setViewControllers([musicViewController], animated: true)
            navigationController.navigationBar.barTintColor = UIColor.systemGray5
            navigationController.navigationBar.standardAppearance = Constants.navigationBarAppearance
            navigationController.tabBarItem.setTitleTextAttributes(Constants.attributes,for: .normal)
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
            navigationController.tabBarItem = UITabBarItem(
                title: "music.title".localized,
                image: UIImage(systemName: "music.note.list"),
                selectedImage: UIImage(systemName: "music.note.list")
            )
        case .video:
            let coordinator = VideoCoordinator()
            let videoViewController = coordinator.showDetail(coordinator: coordinator)

            navigationController.setViewControllers([videoViewController], animated: true)
            navigationController.navigationBar.barTintColor = UIColor.systemGray5
            navigationController.navigationBar.standardAppearance = Constants.navigationBarAppearance
            navigationController.tabBarItem.setTitleTextAttributes(Constants.attributes,for: .normal)
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
            navigationController.tabBarItem = UITabBarItem(
                title: "videos.title".localized,
                image: UIImage(systemName: "video"),
                selectedImage: UIImage(systemName: "video.fill")
            )
        case .favorite:
            let coordinator = FavoriteCoordinator()
            let favoriteViewController = coordinator.showDetail(coordinator: coordinator)

            navigationController.setViewControllers([favoriteViewController], animated: true)
            navigationController.navigationBar.barTintColor = UIColor.systemGray5
            navigationController.navigationBar.standardAppearance = Constants.navigationBarAppearance
            navigationController.tabBarItem.setTitleTextAttributes(Constants.attributes,for: .normal)
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
            navigationController.tabBarItem = UITabBarItem(
                title: "favorite.title".localized,
                image: UIImage(systemName: "bookmark"),
                selectedImage: UIImage(systemName: "bookmark.fill")
            )
        case .locations:
            let coordinator = LocationsCoordinator()
            let locationsViewController = coordinator.showDetail(coordinator: coordinator)

            navigationController.setViewControllers([locationsViewController], animated: true)
            navigationController.navigationBar.barTintColor = UIColor.systemGray5
            navigationController.navigationBar.standardAppearance = Constants.navigationBarAppearance
            navigationController.tabBarItem.setTitleTextAttributes(Constants.attributes,for: .normal)
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
            navigationController.tabBarItem = UITabBarItem(
                title: "locations.title".localized,
                image: UIImage(systemName: "location"),
                selectedImage: UIImage(systemName: "location.fill")
            )

        }
    }
    
}
