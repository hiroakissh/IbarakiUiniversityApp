//
//  DateCalculationModel.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2023/01/01.
//

import Foundation

enum DocumentStatus {
    case normal
    case befor1Week
    case befor3Day
    case befor1Day
    case deadline
    case overdue
    case none
}

class DateCalculationModel {

    private func diffDay(date: Date) -> Int {
        // ここは後でよく考える
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let nowDayString = formatter.string(from: now)
        let dateDayString = formatter.string(from: date)
        let nowDay = formatter.date(from: nowDayString)
        let dateDay = formatter.date(from: dateDayString)
        let calendar = Calendar(identifier: .gregorian)

        let diff = calendar.dateComponents([.day], from: nowDay ?? now, to: dateDay ?? now)
        let diffDay = Int(diff.day!)
        return diffDay
    }

    func diffDate(date: Date) -> String {
        let diffDay = diffDay(date: date)
        if diffDay > 0 {
            return "締め切りまで \(diffDay) 日です"
        } else if diffDay == 0 {
            return "今日が提出期限です"
        } else {
            return "提出期限が過ぎています"
        }
    }

    func observeDocumentStatus(date: Date) -> DocumentStatus {
        let diffDay = diffDay(date: date)
        if diffDay == 1 {
            if diffDay > 1 {
                if diffDay >= 3 {
                    if diffDay > 7 {
                        if diffDay > 14 {
                            return .none
                        }
                        return .normal
                    }
                    return .befor1Week
                }
                return .befor3Day
            }
            return .befor1Day
        } else if diffDay == 0 {
            return .deadline
        } else if diffDay < 0 {
            return .overdue
        } else {
            return .none
        }
    }
}
