//
//  EditTeamViewController.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit
import DunkDiveViewModel
import DunkDiveModel
import SnapKit
import StoreKit

class EditTeamViewController: BaseViewController {

    var viewModel: ViewModel?

    private let grabber = UIImageView(image: UIImage(named: "grabber"))
    private let pageTitle = UILabel(text: "Edit team",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Bold", size: 17))
    private let backButton = UIButton(type: .system)
    private let doneButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)

    private let nameField = TextField(placeholder: "Team name")
    private let countryField = TextField(placeholder: "Country")
    private let defaultImage = AddPhotoView()
    private let addImage = UIButton(type: .system)
    private var selectedImage: UIImage?

    var collectionView: UICollectionView!
    private var players: [PlayerModel] = []

    private var isSaved = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let model = self.viewModel?.team else { return }

        self.nameField.text = model.name
        self.countryField.text = model.country
        self.defaultImage.setup(with: model.image)
        self.selectedImage = model.image
        self.players = self.viewModel?.players ?? []
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = UIColor(hex: "#0D1016")

        backButton.setImage(UIImage(named: "systemBack"), for: .normal)
        doneButton.setImage(UIImage(named: "systemDone"), for: .normal)
        deleteButton.setImage(UIImage(systemName: "trash")?.withRenderingMode(.alwaysTemplate), for: .normal)
        deleteButton.tintColor = UIColor(hex: "#FF453A")

        let numberOfColumns: CGFloat = 2
        let spacing: CGFloat = 10
        let totalSpacing = ((numberOfColumns - 1) * spacing) + 10
        let availableWidth = self.view.frame.width - totalSpacing
        let itemWidth = availableWidth / numberOfColumns

        let myLayout = UICollectionViewFlowLayout()
        myLayout.itemSize = CGSize(width: itemWidth, height: 74)
        myLayout.scrollDirection = .vertical
        myLayout.minimumLineSpacing = spacing
        myLayout.minimumInteritemSpacing = spacing
        myLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: myLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(EmptyCollectionViewCell.self)
        collectionView.register(PlayerCollectionViewCell.self)
        collectionView.registerReusableView(CollectionViewHeader.self,
                                            kind: UICollectionView.elementKindSectionHeader)
        collectionView.delegate = self
        collectionView.dataSource = self

        self.view.addSubview(grabber)
        self.view.addSubview(pageTitle)
        self.view.addSubview(backButton)
        self.view.addSubview(doneButton)
        self.view.addSubview(deleteButton)
        self.view.addSubview(nameField)
        self.view.addSubview(countryField)
        self.view.addSubview(defaultImage)
        self.view.addSubview(addImage)
        self.view.addSubview(collectionView)
        setupConstraints()
        makeButtonActions()
        setupTextFieldDelegates()
        setupViewTapHandling()
    }

    override func setupViewModel() {
        super.setupViewModel()
        guard let id = self.viewModel?.team.id else { return }
        self.viewModel?.getPlayers(by: id)
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

        deleteButton.snp.makeConstraints { view in
            view.centerY.equalTo(pageTitle.snp.centerY)
            view.trailing.equalTo(doneButton.snp.leading).inset(-5)
            view.height.equalTo(24)
            view.width.equalTo(22)
        }

        nameField.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(70)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }

        countryField.snp.makeConstraints { view in
            view.top.equalTo(nameField.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(73)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }

        defaultImage.snp.makeConstraints { view in
            view.top.equalTo(nameField.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(50)
            view.height.equalTo(50)
        }

        addImage.snp.makeConstraints { view in
            view.top.equalTo(nameField.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(50)
            view.height.equalTo(50)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalTo(addImage.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }
    }
}


extension EditTeamViewController: IViewModelableController {
    typealias ViewModel = IEditTeamViewModel
}

//MARK: UIGesture & cell's touches
extension EditTeamViewController: UITextFieldDelegate {

    private func setupTextFieldDelegates() {
        self.nameField.delegate = self
        self.countryField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.countryField:
            textFieldDidEndEditing(textField)
            self.nameField.becomeFirstResponder()
        case self.nameField:
            textFieldDidEndEditing(textField)
            self.nameField.resignFirstResponder()
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
        guard let name = nameField.text else { return true }
        guard let country = countryField.text else { return true }

        return name.isEmpty || country.isEmpty
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
extension EditTeamViewController {
    private func makeButtonActions() {
        self.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        self.doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        addImage.addTarget(self, action: #selector(addImageTapped), for: .touchUpInside)
        self.deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }

    @objc func addImageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true)
    }

    @objc func backTapped() {
        self.dismiss(animated: true)
    }

    @objc func deleteTapped() {
        guard let id = self.viewModel?.team.id else { return }
        self.viewModel?.deleteTeam(by: id)
        self.dismiss(animated: true)
    }

    @objc func doneTapped() {
        guard let name = self.nameField.text else { return }
        guard let country = self.countryField.text else { return }
        guard let image = self.selectedImage else { return }
        guard let id = self.viewModel?.team.id else { return }

        self.viewModel?.editTeam(model: .init(id: id,
                                              image: image,
                                              name: name,
                                              country: country))
        self.isSaved = true
        NotificationCenter.default.post(name: Notification.Name("TeamAdded"), object: nil, userInfo: nil)
        self.dismiss(animated: true)
    }

    private func showAlertWithTwoTextFields() {

        let alert = UIAlertController(title: "New player", message: "Add player and his role", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Full name"
            textField.textContentType = .name
        }

        alert.addTextField { (textField) in
            textField.placeholder = "Role"
            textField.textContentType = .countryName
        }

        let loginAction = UIAlertAction(title: "Save", style: .default) { [weak alert] _ in
            guard let textFields = alert?.textFields else { return }
            let fullname = textFields[0].text ?? ""
            let role = textFields[1].text ?? ""

            guard let id = self.viewModel?.team.id else { return }
            let model = PlayerModel(teamId: id,
                                    name: fullname,
                                    position: role)
            let newPlayer = self.viewModel?.addPlayer(model: model)
            self.players.append(newPlayer!)
            self.collectionView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

        alert.addAction(loginAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }
}

extension EditTeamViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.players.count
        return count == 0 ? 1 : count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let count = self.players.count
        if count == 0 {
            let cell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        } else {
            let cell: PlayerCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let player = self.players[indexPath.row]
            cell.setup(with: player.name,
                       and: player.position)

            cell.deleteSubject.sink { [weak self] _ in
                if let player = self?.players[indexPath.row] {
                    self?.viewModel?.deletePlayer(by: player.id!)
                    self?.players.remove(at: indexPath.row)
                    self?.collectionView.reloadData()
                }
            }.store(in: &cell.cancellables)

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: CollectionViewHeader = collectionView.dequeueCollectionReusableView(with: kind, indexPath: indexPath)

        if self.players.count == 0 {
            headerView.setup(with: "Add player")
        } else {
            headerView.setup(with: "\(self.players.count) players")
        }

        headerView.addSubject.sink { [weak self] _ in
            self?.showAlertWithTwoTextFields()
        }.store(in: &headerView.cancellables)

        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 28)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = self.players.count

        if count == 0 {
            return CGSize(width: collectionView.frame.width, height: 150)
        } else {
            let numberOfColumns: CGFloat = 2
            let spacing: CGFloat = 10

            let layout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpacing = layout.sectionInset.left + layout.sectionInset.right + ((numberOfColumns - 1) * layout.minimumInteritemSpacing)

            let availableWidth = collectionView.frame.width - totalSpacing
            let itemWidth = availableWidth / numberOfColumns

            return CGSize(width: itemWidth, height: 74)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell = self.collectionView.cellForItem(at: indexPath) as? GameCollectionViewCell else { return }
//        self.editGame(for: indexPath.row)
    }
}

//MARK: Image Picker
extension EditTeamViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.defaultImage.setup(with: image)
        selectedImage = image
    }
}

//MARK: Preview
import SwiftUI

struct EditTeamViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let editTeamViewController = EditTeamViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<EditTeamViewControllerProvider.ContainerView>) -> EditTeamViewController {
            return editTeamViewController
        }

        func updateUIViewController(_ uiViewController: EditTeamViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<EditTeamViewControllerProvider.ContainerView>) {
        }
    }
}
