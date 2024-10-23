//
//  BetTableViewCell.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit
import SnapKit
import DunkDiveViewModel
import DunkDiveModel
import Combine

final class BetTableViewCell: UITableViewCell, IReusableView {

    private let content = UIView()

    private let date = UILabel(text: "",
                               textColor: UIColor(hex: "#80858E")!,
                               font: UIFont(name: "SFProText-Regular", size: 15))
    private let teamImage = UIImageView()
    private let teamName = UILabel(text: "",
                                   textColor: .white,
                                   font: UIFont(name: "SFProText-Regular", size: 15))
    private let procient = UILabel(text: "",
                                   textColor: .white,
                                   font: UIFont(name: "SFProText-Regular", size: 15))
    private let money = UILabel(text: "",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Regular", size: 20))
    private let strokeView = UIView()
    private let winOrLose = UILabel(text: "",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Regular", size: 11))
    private let profit = UILabel(text: "",
                                 textColor: UIColor(hex: "#80858E")!,
                                 font: UIFont(name: "SFProText-Regular", size: 11))
    private var isWin: Bool = false

    private func setupUI(isWin: Bool) {

        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.content.backgroundColor = UIColor(hex: "#1A202A")
        self.content.layer.cornerRadius = 10

        self.teamName.textAlignment = .left
        self.date.textAlignment = .left
        self.profit.textAlignment = .left

        self.procient.textAlignment = .center
        self.money.textAlignment = .right
        self.winOrLose.textAlignment = .right

        self.teamImage.layer.cornerRadius = 10
        self.teamImage.backgroundColor = .clear
        self.teamImage.contentMode = .scaleToFill
        self.teamImage.layer.masksToBounds = true

        self.strokeView.backgroundColor = UIColor(hex: "#7F7F7F33")?.withAlphaComponent(0.2)

        if isWin {
            procient.layer.masksToBounds = true
            procient.layer.cornerRadius = 6
            procient.backgroundColor = UIColor(hex: "#088C0D")
            money.textColor = UIColor(hex: "#088C0D")
            winOrLose.text = "win"
            winOrLose.textColor = UIColor(hex: "#088C0D")
        } else {
            procient.layer.masksToBounds = true
            procient.layer.cornerRadius = 6
            procient.backgroundColor = UIColor(hex: "#EF441D")
            money.textColor = UIColor(hex: "#EF441D")
            winOrLose.text = "lose"
            winOrLose.textColor = UIColor(hex: "#EF441D")
        }

        addSubview(content)
        self.content.addSubview(date)
        self.content.addSubview(teamImage)
        self.content.addSubview(teamName)
        self.content.addSubview(procient)
        self.content.addSubview(money)
        self.content.addSubview(strokeView)
        self.content.addSubview(profit)
        self.content.addSubview(winOrLose)
        setupConstraints()
    }

    private func setupConstraints() {

        content.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(5)
            view.leading.equalToSuperview().offset(3)
            view.trailing.equalToSuperview().inset(3)
            view.bottom.equalToSuperview().inset(5)
        }

        date.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(17.5)
            view.leading.equalToSuperview().offset(10)
            view.trailing.equalToSuperview().inset(55)
            view.height.equalTo(27)
        }

        teamImage.snp.makeConstraints { view in
            view.top.equalTo(date.snp.bottom).offset(10.5)
            view.leading.equalToSuperview().offset(10)
            view.width.equalTo(20)
            view.height.equalTo(20)
        }

        teamName.snp.makeConstraints { view in
            view.top.equalTo(date.snp.bottom).offset(10.5)
            view.leading.equalTo(teamImage.snp.trailing).offset(2)
            view.trailing.equalToSuperview().inset(10)
            view.height.equalTo(20)
        }

        procient.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(14)
            view.trailing.equalToSuperview().inset(10)
            view.width.equalTo(45)
            view.height.equalTo(27)
        }

        money.snp.makeConstraints { view in
            view.top.equalTo(procient.snp.bottom).offset(8)
            view.trailing.equalToSuperview().inset(10)
            view.width.equalTo(120)
            view.height.equalTo(25)
        }

        strokeView.snp.makeConstraints { view in
            view.top.equalTo(money.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(10)
            view.trailing.equalToSuperview().inset(10)
            view.height.equalTo(1)
        }

        profit.snp.makeConstraints { view in
            view.top.equalTo(strokeView.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(10)
            view.trailing.equalToSuperview().inset(39)
            view.height.equalTo(13)
        }

        winOrLose.snp.makeConstraints { view in
            view.centerY.equalTo(profit.snp.centerY)
            view.trailing.equalToSuperview().inset(10)
            view.width.equalTo(45)
            view.height.equalTo(13)
        }
    }

    public func setup(model: BetModel) {
        self.date.text = model.date
        self.teamImage.image = model.teamImage
        self.teamName.text = model.teamName
        self.procient.text = model.odds
        self.money.text = "$\(model.stake)"
        self.profit.text = "+$\(model.winMoney)"
        self.setupUI(isWin: model.isWin)
    }
}
