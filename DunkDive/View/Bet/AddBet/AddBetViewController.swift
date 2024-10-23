//
//  AddBetViewController.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit
import DunkDiveViewModel
import DunkDiveModel
import SnapKit
import StoreKit

class AddBetViewController: BaseViewController {

    var viewModel: ViewModel?

    private let grabber = UIImageView(image: UIImage(named: "grabber"))
    private let pageTitle = UILabel(text: "New bet",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Bold", size: 17))
    private let backButton = UIButton(type: .system)
    private let doneButton = UIButton(type: .system)

    private let segmentedControl = UISegmentedControl(items: ["Win",
                                                              "Lose"])

    var collectionView: UICollectionView!

    private let dateField = TextField(placeholder: "Date")
    private let oddsField = TextField(placeholder: "Odds")
    private let stakeField = TextField(placeholder: "$ Stake")

    private var isWin: Bool = true

    private var selectedTeam: TeamModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = UIColor(hex: "#0D1016")

        backButton.setImage(UIImage(named: "systemBack"), for: .normal)
        doneButton.setImage(UIImage(named: "systemDone"), for: .normal)

        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor(hex: "#1A202A")
        segmentedControl.selectedSegmentTintColor = UIColor(hex: "#088C0D")

        segmentedControl.layer.cornerRadius = 7
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)

        let myLayout = UICollectionViewFlowLayout()
        myLayout.itemSize = CGSize(width: 225, height: 80)
        myLayout.scrollDirection = .horizontal
        myLayout.minimumLineSpacing = 10
        myLayout.minimumInteritemSpacing = 10

        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: myLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.register(EmptyCollectionViewCell.self)
        collectionView.register(TeamCollectionViewCell.self)

        collectionView.delegate = self
        collectionView.dataSource = self

        self.view.addSubview(grabber)
        self.view.addSubview(pageTitle)
        self.view.addSubview(backButton)
        self.view.addSubview(doneButton)
        self.view.addSubview(segmentedControl)
        self.view.addSubview(collectionView)
        self.view.addSubview(dateField)
        self.view.addSubview(oddsField)
        self.view.addSubview(stakeField)
        setupConstraints()
        makeButtonActions()
        setupTextFieldDelegates()
        setupViewTapHandling()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadData()
        self.collectionView.reloadData()
    }

    func setupConstraints() {
        grabber.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(5)
            view.centerX.equalToSuperview()
            view.height.equalTo(5)
            view.width.equalTo(36)
        }

        pageTitle.snp.makeConstraints { view in
            view.top.equalTo(grabber.snp.bottom).offset(15)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }

        backButton.snp.makeConstraints { view in
            view.centerY.equalTo(pageTitle.snp.centerY)
            view.leading.equalToSuperview()
            view.height.equalTo(44)
            view.width.equalTo(78)
        }

        doneButton.snp.makeConstraints { view in
            view.centerY.equalTo(pageTitle.snp.centerY)
            view.trailing.equalToSuperview().inset(6)
            view.height.equalTo(22)
            view.width.equalTo(25)
        }

        segmentedControl.snp.makeConstraints { view in
            view.top.equalTo(backButton.snp.bottom).offset(18)
            view.leading.equalToSuperview().offset(17)
            view.trailing.equalToSuperview().inset(17)
            view.height.equalTo(24)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalTo(segmentedControl.snp.bottom).offset(20)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview()
            view.height.equalTo(80)
        }

        dateField.snp.makeConstraints { view in
            view.top.equalTo(collectionView.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }

        oddsField.snp.makeConstraints { view in
            view.top.equalTo(dateField.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(88)
            view.height.equalTo(50)
        }

        stakeField.snp.makeConstraints { view in
            view.top.equalTo(dateField.snp.bottom).offset(16)
            view.leading.equalTo(oddsField.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }
    }
}


extension AddBetViewController: IViewModelableController {
    typealias ViewModel = IAddBetViewModel
}

//MARK: UIGesture & cell's touches
extension AddBetViewController: UITextFieldDelegate {

    private func setupTextFieldDelegates() {
        self.dateField.delegate = self
        self.oddsField.delegate = self
        self.stakeField.delegate = self

        stakeField.keyboardType = .numberPad
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.dateField:
            textFieldDidEndEditing(textField)
            self.oddsField.becomeFirstResponder()
        case self.oddsField:
            textFieldDidEndEditing(textField)
            self.stakeField.becomeFirstResponder()
        case self.stakeField:
            textFieldDidEndEditing(textField)
            self.stakeField.resignFirstResponder()
        default:
            break
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButtonBackgroundColor()
    }

    private func updateButtonBackgroundColor() {
        let allFieldsFilled = !checkAllFields()
        self.doneButton.isUserInteractionEnabled = allFieldsFilled ? true : false
    }

    private func checkAllFields() -> Bool {
        guard let date = dateField.text else { return true }
        guard let odds = oddsField.text else { return true }
        guard let stake = stakeField.text else { return true }

        return date.isEmpty || odds.isEmpty || stake.isEmpty
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    private func setupViewTapHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
}

//MARK: Button Actions
extension AddBetViewController {
    private func makeButtonActions() {
        self.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        self.doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }

    @objc func segmentChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            segmentedControl.selectedSegmentTintColor = UIColor(hex: "#088C0D")
            self.isWin = true
        case 1:
            segmentedControl.selectedSegmentTintColor = UIColor(hex: "#E02020")
            self.isWin = false
        default:
            break
        }
    }

    @objc func backTapped() {
        self.dismiss(animated: true)
    }

    @objc func doneTapped() {
        guard let date = self.dateField.text else { return }
        guard let odd = self.oddsField.text else { return }
        guard let stake = self.stakeField.text else { return }
        guard let team = self.selectedTeam else { return }

        self.viewModel?.addBet(model: .init(teamId: team.id!,
                                            teamName: team.name,
                                            teamImage: team.image,
                                            date: date,
                                            odds: odd,
                                            stake: stake,
                                            winMoney: "150",
                                            isWin: self.isWin))

        self.dismiss(animated: true)
    }
}

extension AddBetViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.viewModel?.teams.count ?? 0
        return count == 0 ? 1 : count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let count = self.viewModel?.teams.count ?? 0
        if count == 0 {
            let cell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        } else {
            let cell: TeamCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            if let player = self.viewModel?.teams[indexPath.row] {
                cell.setup(teamImage: player.image,
                           name: player.name,
                           country: player.country)
            }

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = self.viewModel?.teams.count ?? 0

        if count == 0 {
            return CGSize(width: collectionView.frame.width, height: 150)
        } else {
            return CGSize(width: 225, height: 80)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let count = self.viewModel?.teams.count ?? 0
        if count > 0, let selectedTeam = self.viewModel?.teams[indexPath.row] {
            self.selectedTeam = selectedTeam
            if let cell = collectionView.cellForItem(at: indexPath) as? TeamCollectionViewCell {
                cell.setSelectedState(true)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TeamCollectionViewCell {
                cell.setSelectedState(false)
            }
    }
}

//MARK: Preview
import SwiftUI

struct AddBetViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let addBetViewController = AddBetViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<AddBetViewControllerProvider.ContainerView>) -> AddBetViewController {
            return addBetViewController
        }

        func updateUIViewController(_ uiViewController: AddBetViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AddBetViewControllerProvider.ContainerView>) {
        }
    }
}
