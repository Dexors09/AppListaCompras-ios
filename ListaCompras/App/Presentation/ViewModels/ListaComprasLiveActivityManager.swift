//
//  ListaComprasLiveActivityManager.swift
//  ListaCompras
//
//  Created by Osvaldo González on 15/11/25.
//

import ActivityKit

final class ListaComprasLiveActivityManager {
    static let shared = ListaComprasLiveActivityManager()
    private init() {}

    private var activity: Activity<ListaComprasAttributes>?

    func startOrUpdate(total: Double) {
        print("LiveActivityManager.startOrUpdate total=\(total)")
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("LiveActivityManager: activities NOT enabled")
            return
        }

        let contentState = ListaComprasAttributes.ContentState(total: total)
        let attributes = ListaComprasAttributes()

        if let activity {
            print("LiveActivityManager: updating existing activity")
            Task {
                await activity.update(.init(state: contentState, staleDate: nil))
                print("LiveActivityManager: update called")
            }
        } else {
            print("LiveActivityManager: requesting NEW activity")
            let content = ActivityContent(state: contentState, staleDate: nil)
            Task {
                do {
                    activity = try Activity.request(
                        attributes: attributes,
                        content: content,
                        pushType: nil
                    )
                    print("LiveActivityManager: request OK")
                } catch {
                    print("LiveActivityManager: request FAILED: \(error)")
                }
            }
        }
    }

    func end() {
        print("LiveActivityManager.end()")
        Task {
            await activity?.end(nil, dismissalPolicy: .immediate)
            activity = nil
        }
    }
}
