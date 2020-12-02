
import Foundation


// Part 1

// Given string with format "Student1 - Group1; Student2 - Group2; ..."

let studentsStr = "Бортнік Василь - ІВ-72; Чередніченко Владислав - ІВ-73; Гуменюк Олександр - ІВ-71; Корнійчук Ольга - ІВ-71; Киба Олег - ІВ-72; Капінус Артем - ІВ-73; Овчарова Юстіна - ІВ-72; Науменко Павло - ІВ-73; Трудов Антон - ІВ-71; Музика Олександр - ІВ-71; Давиденко Костянтин - ІВ-73; Андрющенко Данило - ІВ-71; Тимко Андрій - ІВ-72; Феофанов Іван - ІВ-71; Гончар Юрій - ІВ-73"

// Task 1
// Create dictionary:
// - key is a group name
// - value is sorted array with students

var studentsGroups: [String: [String]] = [:]

// Your code begins


// components like ["Бортнік Василь - ІВ-72",.....]
let studentAndGroupStrs = studentsStr.components(separatedBy: "; ")
// pairs like [["Бортнік Василь", "ІВ-72"],....]
let pairs = studentAndGroupStrs.map{ $0.components(separatedBy: " - ") }


for pair in pairs {
    // if no group with such key in dict
    if studentsGroups[pair[1]] == nil {
        // create one and add first student there
        studentsGroups[pair[1]] = [pair[0]]
    } else {
        // else append sudent to existing group
        studentsGroups[pair[1]]!.append(pair[0])
    }
    
}

// for each group
for group in studentsGroups.keys {
    // sort students there
    studentsGroups[group]!.sort()
}



// Your code ends

print(studentsGroups)
print()

// Given array with expected max points

let points: [Int] = [5, 8, 12, 12, 12, 12, 12, 12, 15]

// Task 2
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is array with points (fill it with random values, use function `randomValue(maxValue: Int) -> Int` )

func randomValue(maxValue: Int) -> Int {
    switch(arc4random_uniform(6)) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// Your code begins

// for each group
for group in studentsGroups.keys {
    studentPoints[group] = [:]
    
    // for each student in group
    for student in studentsGroups[group]! {
        studentPoints[group]![student] = []
        // get random points
        for maxPoints in points {
            studentPoints[group]![student]!.append(randomValue(maxValue: maxPoints))
            
        }
        
    }
}


// Your code ends

print(studentPoints)
print()

// Task 3
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is sum of student's points

var sumPoints: [String: [String: Int]] = [:]

// Your code begins

// for each group
for group in studentsGroups.keys {
    
    sumPoints[group] = [:]
    
    // for each student in group
    for (student, marks) in studentPoints[group]! {
        
        //calculate sudent total
        for mark in marks {
            
            sumPoints[group]![student] = (sumPoints[group]![student] ?? 0) + mark
        }
        
    }
}



// Your code ends

print(sumPoints)
print()

// Task 4
// Create dictionary:
// - key is group name
// - value is average of all students points

var groupAvg: [String: Float] = [:]

// Your code begins

// for each group
for group in studentsGroups.keys {
    
    let studentsInGroup = sumPoints[group]!.values.count
    var groupTotal = 0
    
    for (_, studentTotalMarks) in sumPoints[group]! {
        groupTotal += studentTotalMarks
    }
    groupAvg[group] = Float(groupTotal) / Float(studentsInGroup)
    
}

// Your code ends

print(groupAvg)
print()

// Task 5
// Create dictionary:
// - key is group name
// - value is array of students that have >= 60 points

var passedPerGroup: [String: [String]] = [:]

// Your code begins

for group in studentsGroups.keys {
    
    passedPerGroup[group] = []
    
    for (student, mark) in sumPoints[group]! {
        if mark >= 60 {
            passedPerGroup[group]!.append(student)
        }
    }
}


// Your code ends

print(passedPerGroup)

// Example of output. Your results will differ because random is used to fill points.
//
//["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
//["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
//["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
//
//["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
//
//["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]

enum Direction {
    case lat
    case lon
}


class CoordinateOA {
    
    var direction: Direction
    var degree: Int
    var minutes: UInt
    var seconds: UInt
    
    init() {
        self.direction = Direction.lat
        self.degree = 0
        self.minutes = 0
        self.seconds = 0
    }
    
    init(degree: Int, minutes: UInt, seconds: UInt, direction: Direction) {
        self.direction = direction
        if (0 <= minutes && minutes < 60) {
            self.minutes = minutes
        } else {
            self.minutes = 0
        }
        if (0 <= seconds && seconds < 60) {
            self.seconds = seconds
        } else {
            self.seconds = 0
        }
        
        if (-180 <= degree && degree < 180) {
            self.degree = degree
        } else {
            self.degree = 0
        }
        
    }
    
    func location() -> String {
        return "\(degree)°​​\(minutes)′\(seconds)\"​ \(compasDirection)"
    }
    
    func decimalLocation() -> String {
        var returnString = ""
        if degree < 0 {
            returnString += "-"
        }
        returnString += String((Double(degree) * 3600.0  + Double(minutes) * 60.0 + Double(seconds)) / 3600.0)
        returnString += compasDirection
        return returnString
    }
    
    var compasDirection: String {
        
        if direction == Direction.lat {
            if degree >= 0 {
                return "N"
            } else {
                return "S"
            }
        } else {
            if degree >= 0 {
                return "E"
            } else {
                return "W"
            }
        }
    }
    
    func middleCoordinate(to coordinate: CoordinateOA) -> CoordinateOA? {
        guard self.direction == coordinate.direction else {
            return nil
        }
        
        return CoordinateOA(degree: (degree + coordinate.degree) / 2,
                            minutes: (minutes + coordinate.minutes) / 2,
                            seconds: (seconds + coordinate.seconds) / 2,
                            direction: self.direction)
    }
    
    static func middle(from startCoordinate: CoordinateOA, to endCoordinate: CoordinateOA) -> CoordinateOA? {
        return startCoordinate.middleCoordinate(to: endCoordinate)
    }
    
}

let coord1 = CoordinateOA()
print(coord1.location(), coord1.decimalLocation())
print()

let coord2 = CoordinateOA(degree: 1234, minutes: 00, seconds: 12345, direction: .lat)
print(coord2.decimalLocation())
print()

let coord3 = CoordinateOA(degree: 45, minutes: 23, seconds: 43, direction: .lat)
print(coord3.location())
print()

let coord4 = CoordinateOA(degree: 179, minutes: 50, seconds: 21, direction: .lon)
print(coord4.location())
print()

print(CoordinateOA.middle(from: coord3, to: coord4)?.decimalLocation())
print()

let coord5 = CoordinateOA(degree: -119, minutes: 30, seconds: 21, direction: .lon)
print(coord5.decimalLocation())
print()

print(CoordinateOA.middle(from: coord4, to: coord5)?.location())
print()


class TimeOA {
    
    var hours: UInt
    var minutes: UInt
    var seconds: UInt
    
    init() {
        self.hours = 0
        self.minutes = 0
        self.seconds = 0
    }
    
    init(hours: UInt, minutes: UInt, seconds: UInt) {

        self.hours = (0 <= hours && hours < 24 ? hours : 0)
        self.minutes = (0 <= minutes && minutes < 60 ? minutes : 0)
        self.seconds = (0 <= seconds && seconds < 60 ? seconds : 0)
        
    }
    
    init(from date: Date) {
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        
        self.hours = UInt(dateComponents.hour ?? 0)
        self.minutes = UInt(dateComponents.minute ?? 0)
        self.seconds = UInt(dateComponents.second ?? 0)
        
    }
    
    func inString() -> String {
        return "\(hours % 12):\(minutes):\(seconds) \(partOfDay)"
    }
    
    var partOfDay: String {
        if hours >= 12 {
            return "PM"
        } else {
            return "AM"
        }
    }
    
    static func +(lhs: TimeOA, rhs: TimeOA) -> TimeOA {
        var hour: UInt = 0
        var minute: UInt = 0
        var second: UInt = 0
        
        second = (lhs.seconds + rhs.seconds)
        if second >= 60 {
            second %= 60
            minute += 1
        }
        
        minute = (minute + lhs.minutes + rhs.minutes)
        if minute >= 60 {
            minute %= 60
            hour += 1
        }
        
        hour = (hour + lhs.hours + rhs.hours) % 24
        
        return TimeOA(hours: hour, minutes: minute, seconds: second)
    }
    
    static func -(lhs: TimeOA, rhs: TimeOA) -> TimeOA {
        var hour: Int = 0
        var minute: Int = 0
        var second: Int = 0
        
        second = Int(lhs.seconds) - Int(rhs.seconds)
        if second < 0 {
            second = (60 + second) % 60
            minute -= 1
        }
        
        minute = (minute + Int(lhs.minutes) - Int(rhs.minutes))
        if minute < 0 {
            minute = (60 + minute) % 60
            hour -= 1
        }
        
        hour = (hour + Int(lhs.hours) - Int(rhs.hours))
        if hour < 0 {
            hour = (hour + 24) % 24
        }
        
        return TimeOA(hours: UInt(hour), minutes: UInt(minute), seconds: UInt(second))
    }
    
    func plus(_ time: TimeOA) -> TimeOA {
        return self + time
    }
    
    func minus(_ time: TimeOA) -> TimeOA {
        return self - time
    }
    
    static func plus(_ time1: TimeOA, _ time2: TimeOA) -> TimeOA {
        return time1 + time2
    }
    
    static func minus(_ time1: TimeOA, _ time2: TimeOA) -> TimeOA {
        return time1 - time2
    }
}


let time1 = TimeOA()
print(time1.inString())
print()

let time2 = TimeOA(hours: 3, minutes: 37, seconds: 12)
print(time2.inString())
print()

let time3 = TimeOA(hours: 99, minutes: 17, seconds: 23)
print(time3.inString())
print()

let time4 = TimeOA(from: Date())
print(time4.inString())
print()

let time5 = time3 + time3
print(time5.inString())
print()

let time6 = TimeOA.plus(TimeOA(hours: 23, minutes: 59, seconds: 59), TimeOA(hours: 12, minutes: 0, seconds: 1))
print(time6.inString())
print()

let time7 = TimeOA.minus(TimeOA(hours: 0, minutes: 0, seconds: 0), TimeOA(hours: 0, minutes: 0, seconds: 1))
print(time7.inString())
print()
