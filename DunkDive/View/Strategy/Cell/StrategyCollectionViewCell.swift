//
//  StrategyCollectionViewCell.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit
import SnapKit
import DunkDiveViewModel
import Combine

final class StrategyCollectionViewCell: UICollectionViewCell, IReusableView {

    private let strategyImage = UIImageView()
    private let title = UILabel(text: "",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Regular", size: 17))
    private let date = UILabel(text: "",
                               textColor: .white.withAlphaComponent(0.5),
                               font: UIFont(name: "SFProText-Regular", size: 11))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.backgroundColor = UIColor(hex: "#1A202A")
        self.layer.cornerRadius = 10

        self.date.textAlignment = .left
        self.title.textAlignment = .left
        self.title.numberOfLines = 2

        self.strategyImage.layer.cornerRadius = 3
        self.strategyImage.backgroundColor = .clear
        self.strategyImage.contentMode = .scaleToFill
        self.strategyImage.layer.masksToBounds = true

        self.addSubview(date)
        self.addSubview(strategyImage)
        self.addSubview(title)
        setupConstraints()
    }

    private func setupConstraints() {

        date.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(10)
            view.leading.equalToSuperview().offset(10)
            view.width.equalTo(90)
            view.height.equalTo(13)
        }

        strategyImage.snp.makeConstraints { view in
            view.top.equalTo(date.snp.bottom).offset(10)
            view.leading.equalToSuperview().offset(10)
            view.width.equalTo(60)
            view.height.equalTo(60)
        }

        title.snp.makeConstraints { view in
            view.top.equalTo(strategyImage.snp.bottom).offset(3)
            view.leading.equalToSuperview().offset(10)
            view.trailing.equalToSuperview().inset(60)
            view.height.equalTo(44)
        }
    }

    public func setup(strategyImage: UIImage,
                      date: String,
                      title: String) {
        self.strategyImage.image = strategyImage
        self.date.text = date
        self.title.text = title
    }
}

