//
//  MainViewController.swift
//  countDown
//
//  Created by 林華淵 on 2022/3/22.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var countDownDatas: [CountDownData] = []
    let queue = DispatchQueue.global(qos: .background)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBasicViews()
    }
    
    let containerView = UIView()
    func setBasicViews(){
        let titleLabel = UILabel()
        titleLabel.text = "倒數計時"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(statusBarHeight+10)
        }
        
        let plusBtn = UIImageView(image: UIImage(systemName: "plus"))
        plusBtn.changeTo(color: .systemBlue)
        view.addSubview(plusBtn)
        plusBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(20)
        }
        
        /// 讓點擊範圍變大
        let plusArea = UIView()
        plusArea.backgroundColor = .clear
        view.addSubview(plusArea)
        plusArea.snp.makeConstraints { make in
            make.center.equalTo(plusBtn)
            make.width.height.equalTo(plusBtn).offset(10)
        }
        
        plusArea.addTapGestureRecognizer {
            let ncdVC = NewCountDownViewController()
            ncdVC.modalPresentationStyle = .popover
            ncdVC.addDataDelegate = self
            self.present(ncdVC, animated: true, completion: nil)
        }
        
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-bottomSafeAreaHeight-10)
        }
        
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(0) // init
        }
    }
}

extension MainViewController: AddDataDelegate{
    func addData(pjName: String, inputDate: Date) {
        var tempName = pjName
        if tempName == ""{
            tempName = "項目 \(countDownDatas.count + 1)"
        }
        countDownDatas.append(CountDownData(projectName: tempName, targetDate: inputDate))
        
        let index = countDownDatas.count - 1
        
        let dataBKView = UIView()
        dataBKView.layer.borderWidth = 1
        dataBKView.backgroundColor = .clear
        containerView.addSubview(dataBKView)
        dataBKView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding + (cellHeight+padding) * CGFloat(index/2))
            make.left.equalToSuperview().offset(index%2 == 0 ? padding : padding + cellWidth + padding)
            make.width.equalTo(cellWidth)
            make.height.equalTo(cellHeight)
        }
        
        containerView.snp.updateConstraints { make in
            make.height.equalTo(padding + (cellHeight + padding) * CGFloat(index/2 + 1))
        }
        
        let pjNameLabel = UILabel()
        pjNameLabel.text = countDownDatas[index].projectName
        pjNameLabel.textColor = .black
        pjNameLabel.font = .systemFont(ofSize: 16)
        dataBKView.addSubview(pjNameLabel)
        pjNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-cellHeight/6)
            make.centerX.equalToSuperview()
        }
        
        let minLabel = UILabel()
        minLabel.text = "--"
        minLabel.textColor = .black
        minLabel.font = .systemFont(ofSize: 16)
        dataBKView.addSubview(minLabel)
        minLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(cellHeight/6)
            make.centerX.equalToSuperview()
        }
        
        let leftColonLabel = UILabel()
        leftColonLabel.text = ":"
        leftColonLabel.textColor = .black
        leftColonLabel.font = .systemFont(ofSize: 16)
        dataBKView.addSubview(leftColonLabel)
        leftColonLabel.snp.makeConstraints { make in
            make.centerY.equalTo(minLabel)
            make.right.equalTo(minLabel.snp.left).offset(-padding)
        }
        
        let hrLabel = UILabel()
        hrLabel.text = "---"
        hrLabel.textColor = .black
        hrLabel.font = .systemFont(ofSize: 16)
        dataBKView.addSubview(hrLabel)
        hrLabel.snp.makeConstraints { make in
            make.centerY.equalTo(minLabel)
            make.right.equalTo(leftColonLabel.snp.left).offset(-padding)
        }
        
        let rightColonLabel = UILabel()
        rightColonLabel.text = ":"
        rightColonLabel.textColor = .black
        rightColonLabel.font = .systemFont(ofSize: 16)
        dataBKView.addSubview(rightColonLabel)
        rightColonLabel.snp.makeConstraints { make in
            make.centerY.equalTo(minLabel)
            make.left.equalTo(minLabel.snp.right).offset(padding)
        }
        
        let secLabel = UILabel()
        secLabel.text = "--"
        secLabel.textColor = .black
        secLabel.font = .systemFont(ofSize: 16)
        dataBKView.addSubview(secLabel)
        secLabel.snp.makeConstraints { make in
            make.centerY.equalTo(minLabel)
            make.left.equalTo(rightColonLabel.snp.right).offset(padding)
        }
        
        containerView.setBackColorViewTo(targetView: hrLabel, targetColor: .yellow)
        containerView.setBackColorViewTo(targetView: minLabel, targetColor: .yellow)
        containerView.setBackColorViewTo(targetView: secLabel, targetColor: .yellow)
        
        
        let (hrStr,minStr,secStr) = countDownDatas[index].returnNums()

        hrLabel.text = hrStr
        minLabel.text = minStr
        secLabel.text = secStr
        
        /// 設 0.1 視覺上看起來倒數比較合拍
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            let (hrStr,minStr,secStr) = self.countDownDatas[index].returnNums()
            
            hrLabel.text = hrStr
            minLabel.text = minStr
            secLabel.text = secStr
            
            if hrStr == "000" && minStr == "00" && secStr == "00"{
                timer.invalidate()
            }
        })
    }
}
