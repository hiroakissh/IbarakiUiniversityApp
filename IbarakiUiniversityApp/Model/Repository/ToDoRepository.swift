//
//  ToDoRepository.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/04/23.
//

import Foundation
import RealmSwift

final class ToDoRepository {
    // swiftlint:disable:next force_try
    private let realm = try! Realm()

    // 読み込み 共通型で返す
    func loadLabToDo() -> [SwiftLabToDoModel] {
        let realmToDos = realm.objects(RealmToDoModel.self)
        let realmToDosArray = Array(realmToDos)
        let labToDos = realmToDosArray.map {SwiftLabToDoModel(managedObject: $0)}
        return labToDos
    }

    // 共通型で読み込んでRealmに保存
    func appendLabToDo(todo: String) {
        let realmToDo = RealmToDoModel()
        let uuid = UUID()
        realmToDo.todoUUID = uuid.uuidString
        realmToDo.labTODO = todo
        do {
            try realm.write {
            realm.add(realmToDo)
            }
        } catch {
            print("Realm Add Error")
            return
        }
        print(realmToDo)
    }

    // 共通型で受け取って、アイテムの削除
    // アイテムの削除で共通型で返す
    func removeLabToDo(at index: Int) {
        let toDoItems: Results<RealmToDoModel>!
        toDoItems = realm.objects(RealmToDoModel.self)
        do {
            try realm.write {
                realm.delete(toDoItems[index])
            }
        } catch {
                print("Error")
            }
    }

    // 更新
    func updateLabToDo() {
    }
}

private extension SwiftLabToDoModel {
    // 共通型に変換
    init(managedObject: RealmToDoModel) {
        self.uuidString = managedObject.todoUUID
        self.labToDo = managedObject.labTODO
    }

    // Realmオブジェクト変換
    func managedObject() -> RealmToDoModel {
        let realmLabToDo = RealmToDoModel()
        realmLabToDo.todoUUID = self.uuidString
        realmLabToDo.labTODO = self.labToDo
        return realmLabToDo
    }
}
