//
//  TeamCollectionViewCell.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit
import SnapKit
import DunkDiveViewModel
import Combine

final class TeamCollectionViewCell: UICollectionViewCell, IReusableView {

    private let teamImage = UIImageView()
    private let teamName = UILabel(text: "",
                                   textColor: .white,
                                   font: UIFont(name: "SFProText-Regular", size: 22))
    private let country = UILabel(text: "",
                                  textColor: .white.withAlphaComponent(0.5),
                                  font: UIFont(name: "SFProText-Regular", size: 16))

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

        self.teamName.textAlignment = .left
        self.country.textAlignment = .left

        self.teamImage.layer.cornerRadius = 25
        self.teamImage.backgroundColor = .clear
        self.teamImage.contentMode = .scaleToFill
        self.teamImage.layer.masksToBounds = true

        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor

        self.addSubview(teamImage)
        self.addSubview(teamName)
        self.addSubview(country)
        setupConstraints()
    }

    private func setupConstraints() {

        teamImage.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(15)
            view.leading.equalToSuperview().offset(10)
            view.width.equalTo(50)
            view.height.equalTo(50)
        }

        teamName.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(14)
            view.leading.equalTo(teamImage.snp.trailing).offset(10)
            view.trailing.equalToSuperview().inset(10)
            view.height.equalTo(28)
        }

        country.snp.makeConstraints { view in
            view.top.equalTo(teamName.snp.bottom).offset(3)
            view.leading.equalTo(teamImage.snp.trailing).offset(10)
            view.trailing.equalToSuperview().inset(10)
            view.height.equalTo(21)
        }
    }

    public func setSelectedState(_ isSelected: Bool) {
        self.layer.borderColor = isSelected ? UIColor(hex: "#088C0D")!.cgColor : UIColor.clear.cgColor
        self.layer.borderWidth = isSelected ? 1 : 0
    }

    public func setup(teamImage: UIImage,
                      name: String,
                      country: String) {
        self.teamImage.image = teamImage
        self.teamName.text = name
        self.country.text = country
    }
}
