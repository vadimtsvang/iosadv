//
//  LocationsCoordinator.swift
//  Navigation
//
//  Created by Vadim on 07.09.2022.
//

import UIKit

final class LocationsCoordinator {
    func showDetail(coordinator: LocationsCoordinator) -> UIViewController {
        let viewController = LocationsViewController(coordinator: coordinator)
        viewController.view.backgroundColor = .secondarySystemGroupedBackground
        viewController.title = TitleLabels.locationsTitle
        return viewController
    }
}
