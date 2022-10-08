//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Vadim on 12.05.2022.
//

import UIKit

final class FeedCoordinator {
    func showDetail(coordinator: FeedCoordinator) -> UIViewController {
        let viewModel = FeedViewModel()
        let viewController = FeedViewController(model: viewModel, coordinator: coordinator)
        viewController.view.backgroundColor = .secondarySystemGroupedBackground
        viewController.title = "feed.title".localized
        return viewController
    }
}


final class NewPostCoordinator {
    func showDetail(navCon: UINavigationController?, coordinator: NewPostCoordinator) {
        let viewModel = NewPostViewModel()
        let viewController = NewPostViewController(viewModel: viewModel, coordinator: coordinator)
        viewController.view.backgroundColor = .systemGray5
        viewController.title = "newPost.title".localized
        navCon?.pushViewController(viewController, animated: true)
    }
}

final class LoginCoordinator {
    func showDetail(coordinator: LoginCoordinator) -> UIViewController {
        let viewController = LogInViewController()
        let loginFactory = MyLoginFactory()
        viewController.delegate = loginFactory.returnLoginInspector()
        return viewController
    }
}
