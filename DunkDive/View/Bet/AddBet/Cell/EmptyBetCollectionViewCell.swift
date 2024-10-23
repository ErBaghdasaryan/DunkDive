//
//  EmptyBetCollectionViewCell.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit
import DunkDiveModel

final class EmptyBetCollectionViewCell: UICollectionViewCell, IReusableView  {

    private let header = UILabel(text: "You don't have any teams. Add teams so you can use this page",
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

        self.header.textAlignment = .left
        self.header.numberOfLines = 2

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
