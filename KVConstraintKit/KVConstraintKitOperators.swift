//
//  KVConstraintKitOperators.swift
//  KVConstraintKit
//
//  Created by Keshav on 8/16/16.
//  Copyright © 2016 Keshav. All rights reserved.
//

import Foundation

//********* DEFINE NEW OPERATOR *********//
infix operator   <- { }
infix operator  +== { }
infix operator  +>= { }
infix operator  +<= { }
infix operator +*<= { }
infix operator +*== { }
infix operator +*>= { }

infix operator <+==> { }
infix operator <+>=> { }
infix operator <+<=> { }

//Defining operators definations

// MARK: Addable
extension View : Addable { }

/// to add single constraint on the receiver view
public func +(lhs: View, rhs: NSLayoutConstraint) -> NSLayoutConstraint {
    return lhs.applyPreparedConstraintInView(constraint: rhs)
}

/// to add multiple constraints on the receiver view
public func +(lhs: View, rhs: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    for c in rhs {
        constraints.append( lhs + c )
    }
    return constraints
}

// MARK: Accessable
extension View : Accessable { }

public func <-(lhs: View, rhs: NSLayoutAttribute) -> NSLayoutConstraint?{
    return lhs.accessAppliedConstraintBy(attribute: rhs)
}

public func <-(lhs: View, rhs: (NSLayoutAttribute, NSLayoutRelation)) -> NSLayoutConstraint?{
    return lhs.accessAppliedConstraintBy(attribute: rhs.0, relation: rhs.1)
}

// MARK: Removable
extension View : Removable { }

/// to remove single constraint from the receiver view
public func -(lhs: View, rhs: NSLayoutConstraint) -> NSLayoutConstraint {
    lhs.removeConstraint(rhs); return rhs
}

/// to remove multiple constraints from the receiver view
public func -(lhs: View, rhs: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
    if rhs.isEmpty {    return rhs     }
    lhs.removeConstraints(rhs); return rhs
}

//MARK: LayoutRelationable
extension View : LayoutRelationable { }

/// TO ADD SINGLE RELATION CONSTRAINT
//-----------------------------------------
/// (containerView +== .Top).constant = 0

public func +<=(lhs: View, rhs: NSLayoutAttribute) -> NSLayoutConstraint {
    return lhs.superview! + lhs.prepareConstraintToSuperview(attribute: rhs, relation: .LessThanOrEqual)
}

public func +==(lhs: View, rhs: NSLayoutAttribute) -> NSLayoutConstraint {
    return lhs.superview! + lhs.prepareConstraintToSuperview(attribute: rhs, constant: 0)
}

public func +>=(lhs: View, rhs: NSLayoutAttribute) -> NSLayoutConstraint {
    return lhs.superview! + lhs.prepareConstraintToSuperview(attribute: rhs, relation: .GreaterThanOrEqual)
}

/// TO ADD MULTIPLE EQUAL RELATION CONSTRAINT
//----------------------------------------------
/// (containerView +== [.Top, Bottom, Leading, Trailing])

// With defualt constant toCGFloat that is - 0 (Zero) on a specific attribute
public func +<=(lhs: View, rhs: [NSLayoutAttribute]) {
    for attribute in rhs { lhs +<= attribute }
}

public func +==(lhs: View, rhs: [NSLayoutAttribute]) {
    for attribute in rhs { lhs +== attribute }
}

public func +>=(lhs: View, rhs: [NSLayoutAttribute]) {
    for attribute in rhs { lhs +>= attribute }
}

/// TO ADD SINGLE EQUAL RELATION CONSTRAINT WITH MULTIPLEIR
//-------------------------------------------------------------
/// (containerView +== (.Top, 1.5))

public func +*>=(lhs: View, rhs: (NSLayoutAttribute, CGFloat)) -> NSLayoutConstraint {
    return lhs.superview! + lhs.prepareConstraintToSuperview(attribute: rhs.0, relation: .GreaterThanOrEqual, multiplier: rhs.1)
}

/// (containerView *== (.Top, multiplier) ).constant = 0
public func +*==(lhs: View, rhs: (NSLayoutAttribute, CGFloat)) -> NSLayoutConstraint {
    return lhs.superview! + lhs.prepareConstraintToSuperview(attribute: rhs.0, multiplier: rhs.1)
}

public func +*<=(lhs: View, rhs: (NSLayoutAttribute, CGFloat)) -> NSLayoutConstraint {
    return lhs.superview! + lhs.prepareConstraintToSuperview(attribute: rhs.0, relation: .LessThanOrEqual, multiplier: rhs.1)
}


/// TO ADD MULTIPLE RELATION CONSTRAINT WITH MULTIPLEIR
//-------------------------------------------------------------
/// (containerView +== [(.Height, 1.5), (.Width, 0.8)])

public func +*<=(lhs: View, rhs: [(NSLayoutAttribute, CGFloat)]){
    for attribute in rhs { lhs +*<= attribute }
}

public func +*==(lhs: View, rhs: [(NSLayoutAttribute, CGFloat)]){
    for attribute in rhs { lhs +*== attribute }
}
public func +*>=(lhs: View, rhs: [(NSLayoutAttribute, CGFloat)]){
    for attribute in rhs { lhs +*>= attribute }
}
