//
//  RxEasing.swift
//  loopdit
//
//  Created by cdann on 9/26/15.
//  Copyright © 2015 Lintmachine. All rights reserved.
//

import Foundation

import RxSwift

public class RxEasing : NSObject {
    
    public typealias EasingFunction = (Float) -> Float
    
    public enum EasingType: UInt {
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
    
    public class func easingFunctionForType(typeObservable:Observable<EasingType>) -> Observable<EasingFunction> {
        return typeObservable.map {
            (easingType:EasingType) -> EasingFunction in
            return easingFunctionForType(easingType)
        }
    }
    
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
    
    public class func easeValues(values:Observable<Float>, withRangeMin min:Float, rangeMax max:Float, easing:EasingFunction) -> Observable<Float> {
        return values.map {
            (value:Float) -> Float in
            return easing(normalizeValueWithinRange(value, min: min, max: max))
        }
    }
    
    public class func scaleNormalizedToRange(normalized:Float, min:Float, max:Float) -> Float {
        let range = max - min
        let distance = normalized * range
        return distance + min
    }
    
    public class func normalizeValueWithinRange(value:Float, min:Float, max:Float) -> Float {
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