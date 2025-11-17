//
//  ListaComprasLiveActivityManager.swift
//  ListaCompras
//
//  Created by Osvaldo González on 15/11/25.
//

import ActivityKit
import Foundation

final class ListaComprasLiveActivityManager {
    static let shared = ListaComprasLiveActivityManager()
    private init() {}

    private var activity: Activity<ListaComprasAttributes>?

    func startOrUpdate(total: Double, totalItems: Int) {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {return}

        let contentState = ListaComprasAttributes.ContentState(total: total, totalItems: totalItems)
        let attributes = ListaComprasAttributes()

        if let activity {
            Task {
                await activity.update(.init(state: contentState, staleDate: Date().addingTimeInterval(120)))
            }
        } else {
            let content = ActivityContent(state: contentState, staleDate: Date().addingTimeInterval(120))
            Task {
                do {
                    activity = try Activity.request(
                        attributes: attributes,
                        content: content,
                        pushType: nil
                    )
                } catch {
                    print("LiveActivityManager: request FAILED: \(error)")
                }
            }
        }
    }

    func end() {
        Task {
            await activity?.end(nil, dismissalPolicy: .immediate)
            activity = nil
        }
    }
}
