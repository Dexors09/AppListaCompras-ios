//
//  ListaComprasWidgetExtensionLiveActivity.swift
//  ListaComprasWidgetExtension
//
//  Created by Osvaldo González on 15/11/25.
//

import ActivityKit
import WidgetKit
import SwiftUI



struct ListaComprasWidgetExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ListaComprasAttributes.self) { context in
            // Lock Screen / banner
            VStack {
                Text("Total actual")
                Text(String(format: "$%.2f", context.state.total))
                    .font(.title)
            }
            .padding()
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded
                DynamicIslandExpandedRegion(.center) {
                    VStack {
                        Text("Total de tu lista")
                        Text(String(format: "$%.2f", context.state.total))
                            .font(.title2).bold()
                    }
                }
            } compactLeading: {
                Text("🛒")
            } compactTrailing: {
                Text(String(format: "$%.0f", context.state.total))
            } minimal: {
                Text(String(format: "$%.0f", context.state.total))
            }
        }
    }
}
