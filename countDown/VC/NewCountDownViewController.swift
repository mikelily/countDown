//
//  NewCountDownViewController.swift
//  countDown
//
//  Created by 林華淵 on 2022/3/22.
//

import UIKit

class NewCountDownViewController: UIViewController {
    
    weak var addDataDelegate: AddDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTopLabel()
        setMidViews()
    }
    
    let lightGrayBKView = UIView()
    func setTopLabel(){
        let cancelLabel = UILabel()
        cancelLabel.text = "Cancel"
        cancelLabel.textColor = .systemBlue
        cancelLabel.font = .systemFont(ofSize: 20)
        view.addSubview(cancelLabel)
        cancelLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(20)
        }
        
        cancelLabel.addTapGestureRecognizer {
            self.dismiss(animated: true, completion: nil)
        }
        
        let saveLabel = UILabel()
        saveLabel.text = "Save"
        saveLabel.textColor = .systemBlue
        saveLabel.font = .systemFont(ofSize: 20)
        view.addSubview(saveLabel)
        saveLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        saveLabel.addTapGestureRecognizer {
            self.handleSaveAction()
        }
        
        lightGrayBKView.backgroundColor = .lightGray
        lightGrayBKView.alpha = 0.1
        view.addSubview(lightGrayBKView)
        lightGrayBKView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(cancelLabel.snp.bottom).offset(20)
        }
        view.sendSubviewToBack(lightGrayBKView)
    }
    
    let datePicker = UIDatePicker()
    let projectNameTextField = UITextField()
    func setMidViews(){
//        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .dateAndTime
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(fullScreenSize.height*0.7)
            make.width.equalTo(fullScreenSize.width*0.8)
        }
        
        projectNameTextField.placeholder = "項目名稱"
        projectNameTextField.borderStyle = .roundedRect
        view.addSubview(projectNameTextField)
        projectNameTextField.snp.makeConstraints { make in
//            make.bottom.equalTo(datePicker.snp.top).offset(-20)
            make.top.equalTo(lightGrayBKView.snp.bottom).offset(20)
            make.left.right.equalTo(datePicker)
            make.height.equalTo(50)
        }
    }
    
    func handleSaveAction(){
        print("handleSaveAction")
        print(datePicker.date)
        print(projectNameTextField.text)
        
//        countDownDatas.append(CountDownData(pjName: projectNameTextField.text!, inputDate: datePicker.date))
        
        addDataDelegate?.addData(pjName: projectNameTextField.text!, inputDate: datePicker.date)
        
        self.dismiss(animated: true, completion: nil)
    }
}
