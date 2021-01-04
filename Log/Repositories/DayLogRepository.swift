//
//  DayLogRepository.swift
//  Log
//
//  Created by AzumaSato on 2021/01/01.
//

import Foundation
import Disk

import Firebase
import FirebaseFirestoreSwift
import FirebaseFunctions

import Combine
import Resolver

class BaseDayLogRepository {
  @Published var dayLogs = [DayLog]()
}

protocol DayLogRepository: BaseDayLogRepository {
  func addDayLog(_ dayLog: DayLog)
  func removeDayLog(_ dayLog: DayLog)
  func updateDayLog(_ dayLog: DayLog)
}

class TestDataDayLogRepository: BaseDayLogRepository, DayLogRepository, ObservableObject {
  override init() {
    super.init()
    self.dayLogs = testDayLogs
  }

  func addDayLog(_ dayLog: DayLog) {
    dayLogs.append(dayLog)
  }

  func removeDayLog(_ dayLog: DayLog) {
    if let index = dayLogs.firstIndex(where: { $0.id == dayLog.id }) {
      dayLogs.remove(at: index)
    }
  }

  func updateDayLog(_ dayLog: DayLog) {
    if let index = dayLogs.firstIndex(where: { $0.id == dayLog.id }) {
      dayLogs[index] = dayLog
    }
  }
}

class LocalDayLogRepository: BaseDayLogRepository, DayLogRepository, ObservableObject {
  override init() {
    super.init()
    loadData()
  }

  func addDayLog(_ dayLog: DayLog) {
    dayLogs.append(dayLog)
    saveData()
  }

  func removeDayLog(_ dayLog: DayLog) {
    if let index = dayLogs.firstIndex(where: { $0.id == dayLog.id }) {
      dayLogs.remove(at: index)
      saveData()
    }
  }

  func updateDayLog(_ dayLog: DayLog) {
    if let index = dayLogs.firstIndex(where: { $0.id == dayLog.id }) {
      dayLogs[index] = dayLog
      saveData()
    }
  }

  private func loadData() {
    if let retrievedDayLogs = try? Disk.retrieve("dayLogs.json", from: .documents, as: [DayLog].self) {
      self.dayLogs = retrievedDayLogs
    }
  }

  private func saveData() {
    do {
      try Disk.save(self.dayLogs, to: .documents, as: "dayLogs.json")
    } catch let error as NSError {
      fatalError("""
        Domain: \(error.domain)
        Code: \(error.code)
        Description: \(error.localizedDescription)
        Failure Reason: \(error.localizedFailureReason ?? "")
        Suggestions: \(error.localizedRecoverySuggestion ?? "")
        """)
    }
  }
}

class FirestoreDayLogRepository: BaseDayLogRepository, DayLogRepository, ObservableObject {
  @Injected var db: Firestore
  @Injected var authenticationService: AuthenticationService
  @LazyInjected var functions: Functions

  var dayLogsPath: String = "dayLogs"
  var userId: String = "unknown"

  private var listenerRegistration: ListenerRegistration?
  private var cancellables = Set<AnyCancellable>()

  override init() {
    super.init()

    authenticationService.$user
      .compactMap { user in
        user?.uid
      }
      .assign(to: \.userId, on: self)
      .store(in: &cancellables)

    authenticationService.$user
      .receive(on: DispatchQueue.main)
      .sink { [weak self] user in
        self?.loadData()
      }
      .store(in: &cancellables)
  }

  private func loadData() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
    }
    listenerRegistration = db.collection(dayLogsPath)
      .whereField("userId", isEqualTo: self.userId)
      .order(by: "createdAt")
      .addSnapshotListener({ (querySnapshot, error) in
        if let querySnapshot = querySnapshot {
          self.dayLogs = querySnapshot.documents.compactMap({ document -> DayLog? in
            try? document.data(as: DayLog.self)
          })
        }
      })
  }

  func addDayLog(_ dayLog: DayLog) {
    do {
      var userDayLog = dayLog
      userDayLog.userId = self.userId
      let _ = try db.collection(dayLogsPath).addDocument(from: userDayLog)
    } catch {
      fatalError("Unable to encode task: \(error.localizedDescription).")
    }
  }

  func removeDayLog(_ dayLog: DayLog) {
    if let dayLogID = dayLog.id {
      db.collection(dayLogsPath).document(dayLogID).delete { (error) in
        if let error = error {
          print("Unable to remove document: \(error.localizedDescription)")
        }
      }
    }
  }

  func updateDayLog(_ dayLog: DayLog) {
    if let dayLogID = dayLog.id {
      do {
        var updatedDayLog = dayLog
        updatedDayLog.updatedAt = Timestamp()
        try db.collection(dayLogsPath).document(dayLogID).setData(from: updatedDayLog)
      } catch {
        fatalError("Unable to encode task: \(error.localizedDescription).")
      }
    }
  }

  func migrateDayLogs(from idToken: String) {
    let parameters = ["idToken": idToken]
    functions.httpsCallable("migrateDayLogs").call(parameters) { (result, error) in
      if let error = error as NSError? {
        print("Error: \(error.localizedDescription)")
      }
      print("Function result: \(result?.data ?? "(empty)")")
    }
  }
}
