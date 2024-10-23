//
//  EmptyStrategyCollectionViewCell.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit
import DunkDiveModel

final class EmptyStrategyCollectionViewCell: UICollectionViewCell, IReusableView  {

    private let header = UILabel(text: "To add a strategy click a button above",
                                 textColor: .white.withAlphaComponent(0.5),
                                 font: UIFont(name: "SFProText-Regular", size: 15))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.backgroundColor = UIColor(hex: "#0D1016")

        self.header.textAlignment = .center

        self.addSubview(header)
        setupConstraints()
    }

    private func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(22)
        }
    }
}
