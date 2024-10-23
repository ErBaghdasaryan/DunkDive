//
//  AddStrategyViewController.swift
//  DunkDive
//
//  Created by Er Baghdasaryan on 23.10.24.
//

import UIKit
import DunkDiveViewModel
import DunkDiveModel
import SnapKit
import StoreKit

class AddStrategyViewController: BaseViewController {

    var viewModel: ViewModel?

    private let grabber = UIImageView(image: UIImage(named: "grabber"))
    private let pageTitle = UILabel(text: "Add new strategy",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Bold", size: 17))
    private let backButton = UIButton(type: .system)
    private let doneButton = UIButton(type: .system)

    private let defaultImage = AddStrategyPhoto()
    private let addImage = UIButton(type: .system)
    private let titleField = TextField(placeholder: "Title")
    private let dateField = TextField(placeholder: "Date")

    private var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = UIColor(hex: "#0D1016")

        backButton.setImage(UIImage(named: "systemBack"), for: .normal)
        doneButton.setImage(UIImage(named: "systemDone"), for: .normal)

        self.view.addSubview(grabber)
        self.view.addSubview(pageTitle)
        self.view.addSubview(backButton)
        self.view.addSubview(doneButton)
        self.view.addSubview(defaultImage)
        self.view.addSubview(addImage)
        self.view.addSubview(titleField)
        self.view.addSubview(dateField)
        setupConstraints()
        makeButtonActions()
        setupTextFieldDelegates()
        setupViewTapHandling()
    }

    override func setupViewModel() {
        super.setupViewModel()
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

        defaultImage.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(70)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(220)
        }

        addImage.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(70)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(220)
        }

        titleField.snp.makeConstraints { view in
            view.top.equalTo(defaultImage.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }

        dateField.snp.makeConstraints { view in
            view.top.equalTo(titleField.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }
    }
}


extension AddStrategyViewController: IViewModelableController {
    typealias ViewModel = IAddStrategyViewModel
}

//MARK: UIGesture & cell's touches
extension AddStrategyViewController: UITextFieldDelegate {

    private func setupTextFieldDelegates() {
        self.titleField.delegate = self
        self.dateField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.titleField:
            textFieldDidEndEditing(textField)
            self.dateField.becomeFirstResponder()
        case self.dateField:
            textFieldDidEndEditing(textField)
            self.dateField.resignFirstResponder()
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
        guard let title = titleField.text else { return true }
        guard let date = dateField.text else { return true }

        return title.isEmpty || date.isEmpty
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
extension AddStrategyViewController {
    private func makeButtonActions() {
        self.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        self.doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        addImage.addTarget(self, action: #selector(addImageTapped), for: .touchUpInside)
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

    @objc func doneTapped() {
        guard let title = self.titleField.text else { return }
        guard let date = self.dateField.text else { return }
        guard let image = self.selectedImage else { return }

        self.viewModel?.addStrategy(model: .init(image: image,
                                                 title: title,
                                                 date: date))

        self.dismiss(animated: true)
    }
}

//MARK: Image Picker
extension AddStrategyViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.defaultImage.setup(with: image)
        selectedImage = image
    }
}

//MARK: Preview
import SwiftUI

struct AddStrategyViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let addStrategyViewController = AddStrategyViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<AddStrategyViewControllerProvider.ContainerView>) -> AddStrategyViewController {
            return addStrategyViewController
        }

        func updateUIViewController(_ uiViewController: AddStrategyViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AddStrategyViewControllerProvider.ContainerView>) {
        }
    }
}
