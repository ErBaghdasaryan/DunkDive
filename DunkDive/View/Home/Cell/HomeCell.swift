//
//  HomeCell.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit
import SnapKit
import DunkDiveViewModel

final class HomeCell: UICollectionViewCell, IReusableView {

    private var image = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        self.addSubview(image)
    }

    private func setupConstraints() {
        image.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }
    }

    public func setup(image: String) {
        self.image.image = UIImage(named: image)
    }
}