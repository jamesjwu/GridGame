//
//  SquareGameBoard.swift
//  GridGame
//
//  Created by James Wu on 10/7/14.
//  Copyright (c) 2014 James Wu. All rights reserved.
//

import Foundation
import UIKit


/// Taken from swift-2048
/// An enum representing directions supported by the game model.
enum MoveDirection {
  case Up
  case Down
  case Left
  case Right
}

/// An enum representing a movement command issued by the view controller as the result of the user swiping.
struct MoveCommand {
  var direction: MoveDirection
  var completion: (Bool) -> ()
  init(d: MoveDirection, c: (Bool) -> ()) {
    direction = d
    completion = c
  }
}

enum GridObject {
  case Empty
  case Ball //there's a ball here
  case Hole //location to put the Ball
  case Block //a wall blocking the ball
}

protocol GameModelProtocol : class {
  func scoreChanged(score: Int)
  func moveBall(from: (Int, Int), to: (Int, Int), value: Int)
}


class GameModel : NSObject {
  let dimension: Int
  let threshold: Int
  
  let delegate = GameModelProtocol
  
  var score: Int = 0 {
    didSet {
      delegate.scoreChanged(score)
    }
  }
  
  var gameboard = SquareGameBoard<TileObject>


}







/// A struct representing a square gameboard. Because this struct uses generics, it could conceivably be used to
/// represent state for many other games without modification.
struct SquareGameboard<T> {
  let dimension: Int
  var boardArray: [T]
  
  init(dimension d: Int, initialValue: T) {
    dimension = d
    boardArray = [T](count:d*d, repeatedValue:initialValue)
  }
  
  subscript(row: Int, col: Int) -> T {
    get {
      assert(row >= 0 && row < dimension)
      assert(col >= 0 && col < dimension)
      return boardArray[row*dimension + col]
    }
    set {
      assert(row >= 0 && row < dimension)
      assert(col >= 0 && col < dimension)
      boardArray[row*dimension + col] = newValue
    }
  }
  
  // We mark this function as 'mutating' since it changes its 'parent' struct.
  mutating func setAll(item: T) {
    for i in 0..<dimension {
      for j in 0..<dimension {
        self[i, j] = item
      }
    }
  }
}