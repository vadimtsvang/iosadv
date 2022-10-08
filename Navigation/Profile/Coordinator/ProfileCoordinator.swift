//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Vadim on 12.05.2022.
//

import UIKit

final class ProfileCoordinator {
    func showDetail(coordinator: ProfileCoordinator) -> UIViewController {
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController(
            userService: TestUserService() as UserService,
            name: "testname",
            viewModel: viewModel,
            coordinator: coordinator)
        viewController.title = "profile.title".localized
        return viewController
    }
}

final class PhotosCoordinator {
    func showDetail(navCon: UINavigationController?, coordinator: PhotosCoordinator) {
        let viewModel = PhotosViewModel()
        let viewController = PhotosViewController(coordinator: coordinator, viewModel: viewModel)
        viewController.view.backgroundColor = .white
        viewController.title = "photos.title".localized
        navCon?.tabBarController?.tabBar.isHidden = true
        navCon?.pushViewController(viewController, animated: true)
    }
    
    func pop(navCon: UINavigationController?) {
        navCon?.popViewController(animated: true)
    }
}
