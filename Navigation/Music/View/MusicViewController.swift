//
//  MusicViewController.swift
//  Navigation
//
//  Created by Vadim on 11.06.2022.
//

import UIKit
import SnapKit

class MusicViewController: UIViewController {
    
    private var viewModel: MusicViewModel?
    private weak var coordinator: MusicCoordinator?
    let playerView = MusicPlayerView()
    
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped )
        table.separatorInset = .zero
        table.rowHeight = UITableView.automaticDimension
        return table
    }()

    init (model: MusicViewModel , coordinator: MusicCoordinator) {
        self.viewModel = model
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(
            MusicTableViewCell.self,
            forCellReuseIdentifier: String(
                describing: MusicTableViewCell.self)
        )

        setupLayout()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        apply(theme: self.interfaceStyle == .light ? .light : .dark)
    }

    private func setupLayout() {
        
        apply(theme: self.interfaceStyle == .light ? .light : .dark)
        
        view.addSubviews(tableView, playerView)

        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(playerView.snp.top)
        }
        
        playerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(80)
            make.height.equalTo(80)
        }
    }
}

extension MusicViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MusicTableViewCell.self), for: indexPath) as? MusicTableViewCell,
        let viewModel = viewModel else { return UITableViewCell() }
        cell.setConfigureOfCell(model: viewModel, index: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MusicViewModel.tracks.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "   \(TitleLabels.musicSectionTitle)"
    }
    
}
    
extension MusicViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playerView.playSelectedTrack(forIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MusicViewController: Themeable {
    
    func apply(theme: Theme) {
        self.view.backgroundColor = theme.colors.palette.backgroud
    }
}
