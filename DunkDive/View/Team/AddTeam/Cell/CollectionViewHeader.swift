//
//  CollectionViewHeader.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit
import SnapKit
import DunkDiveModel
import Combine

final class CollectionViewHeader: UICollectionReusableView, IReusableView {

    private let titleLabel = UILabel(text: "",
                                     textColor: .white,
                                     font: UIFont(name: "SFProText-Semibold", size: 22))
    private let addButton = UIButton(type: .system)
    public var addSubject = PassthroughSubject<Bool, Never>()
    var cancellables = Set<AnyCancellable>()

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
    }

    private func setupUI() {
        addButton.setImage(UIImage(named: "plusHeader"), for: .normal)

        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)

        addSubview(titleLabel)
        addSubview(addButton)
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
        }

        addButton.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.trailing.equalToSuperview()
            view.width.equalTo(26)
            view.height.equalTo(22)
        }
    }

    public func setup(with title: String) {
        self.titleLabel.text = title
        self.setupUI()
    }

    @objc func addButtonTapped() {
        self.addSubject.send(true)
    }
}
