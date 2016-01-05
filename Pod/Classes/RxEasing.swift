//
//  RxEasing.swift
//  loopdit
//
//  Created by cdann on 9/26/15.
//
//  Copyright (c) 2015 Chris D'Annunzio <cdann@lintmachine.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

import RxSwift

public class RxEasing : NSObject {
    
    public typealias EasingFunction = (Double) -> Double
    
    // Enum of standard easing functions
    public enum EasingType: Int {
        case NoInterpolation = 0
        case LinearInterpolation
        case QuadraticEaseIn
        case QuadraticEaseOut
        case QuadraticEaseInOut
        case CubicEaseIn
        case CubicEaseOut
        case CubicEaseInOut
        case QuarticEaseIn
        case QuarticEaseOut
        case QuarticEaseInOut
        case QuinticEaseIn
        case QuinticEaseOut
        case QuinticEaseInOut
        case SineEaseIn
        case SineEaseOut
        case SineEaseInOut
        case CircularEaseIn
        case CircularEaseOut
        case CircularEaseInOut
        case ExponentialEaseIn
        case ExponentialEaseOut
        case ExponentialEaseInOut
        case ElasticEaseIn
        case ElasticEaseOut
        case ElasticEaseInOut
        case BackEaseIn
        case BackEaseOut
        case BackEaseInOut
        case BounceEaseIn
        case BounceEaseOut
        case BounceEaseInOut
        
        case NumTypes
    }
    
    // Maps a stream of EasingType values to a stream of easing functions
    public class func easingFunctionForType(typeObservable:Observable<EasingType>) -> Observable<EasingFunction> {
        return typeObservable.map {
            (easingType:EasingType) -> EasingFunction in
            return easingFunctionForType(easingType)
        }
    }
    
    // Maps an EasingType value to an easing functions
    public class func easingFunctionForType(easingType:EasingType) -> EasingFunction {
        switch easingType {
        case EasingType.NoInterpolation:
            return NoInterpolation
        case EasingType.LinearInterpolation:
            return LinearInterpolation
        case EasingType.QuadraticEaseIn:
            return QuadraticEaseIn
        case EasingType.QuadraticEaseOut:
            return QuadraticEaseOut
        case EasingType.QuadraticEaseInOut:
            return QuadraticEaseInOut
        case EasingType.CubicEaseIn:
            return CubicEaseIn
        case EasingType.CubicEaseOut:
            return CubicEaseOut
        case EasingType.CubicEaseInOut:
            return CubicEaseInOut
        case EasingType.QuarticEaseIn:
            return QuarticEaseIn
        case EasingType.QuarticEaseOut:
            return QuarticEaseOut
        case EasingType.QuarticEaseInOut:
            return QuarticEaseInOut
        case EasingType.QuinticEaseIn:
            return QuinticEaseIn
        case EasingType.QuinticEaseOut:
            return QuinticEaseOut
        case EasingType.QuinticEaseInOut:
            return QuinticEaseInOut
        case EasingType.SineEaseIn:
            return SineEaseIn
        case EasingType.SineEaseOut:
            return SineEaseOut
        case EasingType.SineEaseInOut:
            return SineEaseInOut
        case EasingType.CircularEaseIn:
            return CircularEaseIn
        case EasingType.CircularEaseOut:
            return CircularEaseOut
        case EasingType.CircularEaseInOut:
            return CircularEaseInOut
        case EasingType.ExponentialEaseIn:
            return ExponentialEaseIn
        case EasingType.ExponentialEaseOut:
            return ExponentialEaseOut
        case EasingType.ExponentialEaseInOut:
            return ExponentialEaseInOut
        case EasingType.ElasticEaseIn:
            return ElasticEaseIn
        case EasingType.ElasticEaseOut:
            return ElasticEaseOut
        case EasingType.ElasticEaseInOut:
            return ElasticEaseInOut
        case EasingType.BackEaseIn:
            return BackEaseIn
        case EasingType.BackEaseOut:
            return BackEaseOut
        case EasingType.BackEaseInOut:
            return BackEaseInOut
        case EasingType.BounceEaseIn:
            return BounceEaseIn
        case EasingType.BounceEaseOut:
            return BounceEaseOut
        case EasingType.BounceEaseInOut:
            return BounceEaseInOut
        default:
            return LinearInterpolation
        }
    }
    
    // Apply the easing function to a stream of values. 
    // Input stream values are expected to be within the range specified by min and max. Output values are in the normalized range of 0.0 - 1.0.
    public class func easeValues(values:Observable<Double>, withRangeMin min:Double, rangeMax max:Double, easing:EasingFunction) -> Observable<Double> {
        return values.map {
            (value:Double) -> Double in
            return easing(normalizeValueWithinRange(value, min: min, max: max))
        }
    }

    // Scale the stream of normalized values to the specified range.
    // Input stream values are expected to be within the normalized range of 0.0 - 1.0. Output values are scaled to the range specified by min and max.
    public class func scaleNormalizedValues(values:Observable<Double>, toRangeMin min:Double, rangeMax max:Double) -> Observable<Double> {
        return values.map {
            (value:Double) -> Double in
            return scaleNormalizedToRange(value, min: min, max: max)
        }
    }
    
    public class func scaleNormalizedToRange(normalized:Double, min:Double, max:Double) -> Double {
        let range = max - min
        let distance = normalized * range
        return distance + min
    }
    
    public class func normalizeValueWithinRange(value:Double, min:Double, max:Double) -> Double {
        let range = max - min
        let distance = value - min
        if range > 0.0 {
            return distance / range
        }
        else {
            return 0
        }
    }
}