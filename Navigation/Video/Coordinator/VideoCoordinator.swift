//
//  VideoCoordinator.swift
//  Navigation
//
//  Created by Vadim on 11.06.2022.
//

import UIKit

final class VideoCoordinator {
    func showDetail(coordinator: VideoCoordinator) -> UIViewController {
        let viewModel = VideoViewModel()
        let viewController = VideoViewController(model: viewModel, coordinator: coordinator)
        viewController.view.backgroundColor = .secondarySystemGroupedBackground
        viewController.title = TitleLabels.videosTitle
        return viewController
    }
}

