//
//  TeamEmptyTableViewCell.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit

final class TeamEmptyTableViewCell: UITableViewCell, IReusableView {
    private let header = UILabel(text: "",
                                 textColor: .white.withAlphaComponent(0.5),
                                 font: UIFont(name: "SFProText-Regular", size: 20))

    private func setupUI(add what: String) {

        self.backgroundColor = UIColor(hex: "#0D1016")

        self.header.textAlignment = .center
        self.header.numberOfLines = 2

        self.header.text = what

        self.addSubview(header)
        setupConstraints()
    }

    private func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(48)
        }
    }

    public func setup(with: String) {
        self.setupUI(add: with)
    }
}
