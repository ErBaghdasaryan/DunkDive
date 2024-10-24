//
//  AddTeamPhoto.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit
import DunkDiveModel

final class AddPhotoView: UIView {
    private let defaultImage = UIImageView(image: UIImage(named: "addImage"))
    private var image = UIImageView()

    public init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.backgroundColor = UIColor(hex: "#1A202A")


        self.layer.cornerRadius = 10

        self.image.backgroundColor = .clear
        self.image.contentMode = .scaleToFill
        self.image.layer.masksToBounds = true
        self.image.layer.cornerRadius = 18

        addSubview(defaultImage)
        addSubview(image)
        setupConstraints()
    }

    private func setupConstraints() {
        defaultImage.snp.makeConstraints { view in
            view.centerY.equalToSuperview()
            view.centerX.equalToSuperview()
            view.width.equalTo(24)
            view.height.equalTo(22)
        }

        image.snp.makeConstraints { view in
            view.centerY.equalToSuperview()
            view.centerX.equalToSuperview()
            view.width.equalTo(38)
            view.height.equalTo(38)
        }
    }

    public func setup(with image: UIImage) {
        self.image = UIImageView(image: image)
        self.setupUI()
    }
}