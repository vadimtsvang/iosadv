//
//  FavoriteCoordinator.swift
//  Navigation
//
//  Created by Vadim on 13.07.2022.
//

import UIKit

final class FavoriteCoordinator {
    func showDetail(coordinator: FavoriteCoordinator) -> UIViewController {
        let viewController = FavoriteViewController(coordinator: coordinator)
        viewController.view.backgroundColor = .secondarySystemGroupedBackground
        viewController.title = TitleLabels.favoriteTitle
        return viewController
    }
}
