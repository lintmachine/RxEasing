//
//  ViewController.swift
//  RxEasing
//
//  Created by cdann on 09/28/2015.
//  Copyright (c) 2015 cdann. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional
import RxEasing

import JBChartView

open class ViewController: UIViewController, JBLineChartViewDataSource, JBLineChartViewDelegate {

    @IBOutlet weak var lineChart: JBLineChartView!
    
    @IBOutlet weak var easingFunctionSlider: UISlider!
    @IBOutlet weak var rangeMinTextField: UITextField!
    @IBOutlet weak var rangeMaxTextField: UITextField!
    @IBOutlet weak var inputValueSlider: UISlider!
    @IBOutlet weak var outputValueLabel: UILabel!
    @IBOutlet weak var easingFunctionLabel: UILabel!
    
    var disposeBag = DisposeBag()
    var easingFunction = RxEasing.easingFunctionForType(easingType: .LinearInterpolation)
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lineChart.dataSource = self
        self.lineChart.delegate = self
        
        let easingTypeObservable = self.easingFunctionSlider.rx.value.map {
            [unowned self] (value:Float) -> RxEasing.EasingType in
            let easingType = RxEasing.EasingType(rawValue: Int(value * Float(RxEasing.EasingType.NumTypes.rawValue)) % RxEasing.EasingType.NumTypes.rawValue)!
            self.easingFunctionLabel.rx.text.onNext(self.easingFunctionDisplayName(easingType))
            return easingType
        }
        
        let easingFunction = easingTypeObservable.map {
            (easingType:RxEasing.EasingType) -> RxEasing.EasingFunction in

            let easingFunction = RxEasing.easingFunctionForType(easingType: easingType)
            return easingFunction
        }
        
        let rangeMin = self.rangeMinTextField.rx.text.filterNil().map {
            (stringValue:String) -> Double in
            if let value = Double(stringValue) {
                return value
            }
            return 0.0
        }

        let rangeMax = self.rangeMaxTextField.rx.text.filterNil().map {
            (stringValue:String) -> Double in
            if let value = Double(stringValue) {
                return value
            }
            return 1.0
        }

        let inputValues = inputValueSlider.rx.value.map {
            [unowned self] (value:Float) -> Double in
            self.view.endEditing(true)
            return Double(value)
        }
        
        let easedNormalizedValues = easingFunction.map {
            (easingFunction:@escaping RxEasing.EasingFunction) -> Observable<Double> in
            return RxEasing.easeValues(values: inputValues, withRangeMin: 0.0, rangeMax: 1.0, easing: easingFunction)
        }
        .switchLatest()
        
        Observable.combineLatest(
            easedNormalizedValues,
            rangeMin,
            rangeMax
        ) {
            (normalizedValue, min, max) -> Double in
            return RxEasing.scaleNormalizedToRange(normalized: normalizedValue, min: min, max: max)
        }
        .subscribe(
            onNext: {
                [unowned self] (value:Double) in
                let displayValue = NSString(format: "%0.3f", value)
                self.outputValueLabel.rx.text.onNext(displayValue as String)
                self.lineChart.reloadData()
            }
        )
            .disposed(by: self.disposeBag)
        
        easingFunction.subscribe(
            onNext: {
                [unowned self] (function:@escaping RxEasing.EasingFunction) -> Void in
                self.easingFunction = function
            }
        )
            .disposed(by: self.disposeBag)
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.lineChart.reloadData()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func easingFunctionDisplayName(_ easingType:RxEasing.EasingType) -> String {
        switch easingType {
        case .NoInterpolation:
            return "No Interpolation"
        case .LinearInterpolation:
            return "Linear Interpolation"
        case .QuadraticEaseIn:
            return "Quadratic Ease In"
        case .QuadraticEaseOut:
            return "Quadratic Ease Out"
        case .QuadraticEaseInOut:
            return "Quadratic Ease In/Out"
        case .CubicEaseIn:
            return "Cubic Ease In"
        case .CubicEaseOut:
            return "Cubic Ease Out"
        case .CubicEaseInOut:
            return "Cubic Ease In/Out"
        case .QuarticEaseIn:
            return "Quartic Ease In"
        case .QuarticEaseOut:
            return "Quartic Ease Out"
        case .QuarticEaseInOut:
            return "Quartic Ease In Out"
        case .QuinticEaseIn:
            return "Quintic Ease In"
        case .QuinticEaseOut:
            return "Quintic Ease Out"
        case .QuinticEaseInOut:
            return "Quintic Ease In/Out"
        case .SineEaseIn:
            return "Sine Ease In"
        case .SineEaseOut:
            return "Sine Ease Out"
        case .SineEaseInOut:
            return "Sine Ease In/Out"
        case .CircularEaseIn:
            return "Circular Ease In"
        case .CircularEaseOut:
            return "Circular Ease Out"
        case .CircularEaseInOut:
            return "Circular Ease In/Out"
        case .ExponentialEaseIn:
            return "Exponential Ease In"
        case .ExponentialEaseOut:
            return "Exponential Ease Out"
        case .ExponentialEaseInOut:
            return "Exponential Ease In/Out"
        case .ElasticEaseIn:
            return "Elastic Ease In"
        case .ElasticEaseOut:
            return "Elastic Ease Out"
        case .ElasticEaseInOut:
            return "Elastic Ease In/Out"
        case .BackEaseIn:
            return "Back Ease In"
        case .BackEaseOut:
            return "Back Ease Out"
        case .BackEaseInOut:
            return "Back Ease In/Out"
        case .BounceEaseIn:
            return "Bounce Ease In"
        case .BounceEaseOut:
            return "Bounce Ease Out"
        case .BounceEaseInOut:
            return "Bounce Ease In/Out"
        default:
            return ""
        }
    }
    // MARK: - JBLineChartDataSource
    
    open func numberOfLines(in lineChartView: JBLineChartView!) -> UInt {
        return 2
    }
    
    open func lineChartView(_ lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        switch lineIndex {
        case 1:
            return UIColor(red: 253.0 / 255.0, green: 133.0 / 255.0, blue: 9.0 / 255.0, alpha: 1.0)
        default:
            return UIColor(red: 218.0 / 255.0, green: 243.0 / 255.0, blue: 254.0 / 255.0, alpha: 1.0)
        }
    }
    
    open func lineChartView(_ lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        return UInt(self.lineChart.bounds.size.width)
    }
    
    open func lineChartView(_ lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {

        let time:Double
        
        switch lineIndex {
        case 1:
            time = Double(self.inputValueSlider.value)
        default:
            time = Double(horizontalIndex) / Double(self.lineChart.bounds.size.width)
        }
        
        let halfHeight = self.lineChart.bounds.size.height * 0.5
        return CGFloat(easingFunction(time)) * self.lineChart.bounds.size.height + halfHeight
    }
}

