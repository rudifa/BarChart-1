//
//  ViewController.swift
//  BarChart
//
//  Created by Nguyen Vu Nhat Minh on 19/8/17.
//  Copyright © 2017 Nguyen Vu Nhat Minh. All rights reserved.
//

import BarChartPkg
import UIKit

class ViewController: UIViewController {
    private lazy var basicBarChartView: BasicBarChart = {
        let view = BasicBarChart()
        // view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var beautifulBarChartView: BeautifulBarChart = {
        let view = BeautifulBarChart()
        // view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let numEntry = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(basicBarChartView)
        view.addSubview(beautifulBarChartView)
        setUpLayout()
    }

    func setUpLayout() {
        NSLayoutConstraint.activate([
            basicBarChartView.leftAnchor.constraint(equalTo: view.leftAnchor),
            basicBarChartView.rightAnchor.constraint(equalTo: view.rightAnchor),
            basicBarChartView.topAnchor.constraint(equalTo: view.topAnchor),
            basicBarChartView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            beautifulBarChartView.leftAnchor.constraint(equalTo: view.leftAnchor),
            beautifulBarChartView.rightAnchor.constraint(equalTo: view.rightAnchor),
            beautifulBarChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            beautifulBarChartView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
        ])
    }

    override func viewDidAppear(_: Bool) {
        let dataEntries = generateEmptyDataEntries()
        basicBarChartView.updateDataEntries(dataEntries: dataEntries, animated: false)
        beautifulBarChartView.updateDataEntries(dataEntries: dataEntries, animated: false)

        let timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [unowned self] _ in
            let dataEntries = self.generateRandomDataEntries()
            self.beautifulBarChartView.updateDataEntries(dataEntries: dataEntries, animated: true)
            self.basicBarChartView.updateDataEntries(dataEntries: dataEntries, animated: true)
        }
        timer.fire()
    }

    func generateEmptyDataEntries() -> [DataEntry] {
        var result: [DataEntry] = []
        Array(0 ..< numEntry).forEach { _ in
            result.append(DataEntry(color: UIColor.clear, height: 0, textValue: "0", title: ""))
        }
        return result
    }

    func generateRandomDataEntries() -> [DataEntry] {
        let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        var result: [DataEntry] = []
        for i in 0 ..< numEntry {
            let value = (arc4random() % 90) + 10
            let height: Float = Float(value) / 100.0

            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            var date = Date()
            date.addTimeInterval(TimeInterval(24 * 60 * 60 * i))
            result.append(DataEntry(color: colors[i % colors.count], height: height, textValue: "\(value)", title: formatter.string(from: date)))
        }
        return result
    }
}
