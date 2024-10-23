//
//  PlayerCollectionViewCell.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit
import DunkDiveModel
import Combine

final class PlayerCollectionViewCell: UICollectionViewCell, IReusableView  {

    private let fullName = UILabel(text: "",
                                   textColor: .white,
                                   font: UIFont(name: "SFProText-Regular", size: 17))
    private let position  = UILabel(text: "",
                                    textColor: UIColor(hex: "#80858E")!,
                                    font: UIFont(name: "SFProText-Regular", size: 16))
    private let delete = UIButton(type: .system)

    public var deleteSubject = PassthroughSubject<Bool, Never>()
    var cancellables = Set<AnyCancellable>()

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeButtonActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        makeButtonActions()
    }

    private func setupUI() {
        self.backgroundColor = UIColor(hex: "#1A202A")

        self.layer.cornerRadius = 10

        self.fullName.textAlignment = .left
        self.position.textAlignment = .left

        self.delete.setImage(UIImage(systemName: "trash.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.delete.tintColor = UIColor(hex: "#FF453A")

        self.addSubview(fullName)
        self.addSubview(position)
        self.addSubview(delete)
        setupConstraints()
    }

    private func setupConstraints() {
        fullName.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(14)
            view.leading.equalToSuperview().offset(10)
            view.trailing.equalToSuperview().inset(44)
            view.height.equalTo(22)
        }

        position.snp.makeConstraints { view in
            view.top.equalTo(fullName.snp.bottom).offset(3)
            view.leading.equalToSuperview().offset(10)
            view.trailing.equalToSuperview().inset(44)
            view.height.equalTo(21)
        }

        delete.snp.makeConstraints { view in
            view.centerY.equalToSuperview()
            view.trailing.equalToSuperview().inset(10)
            view.height.equalTo(22)
            view.width.equalTo(20)
        }
    }

    public func setup(with fullName: String, and position: String) {
        self.fullName.text = fullName
        self.position.text = position
    }
}

extension PlayerCollectionViewCell {
    private func makeButtonActions() {
        self.delete.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }

    @objc func deleteTapped() {
        self.deleteSubject.send(true)
    }
}
