//
//  ListaComprasWidgetExtensionLiveActivity.swift
//  ListaComprasWidgetExtension
//
//  Created by Osvaldo González on 15/11/25.
//

import ActivityKit
import WidgetKit
import SwiftUI


@main
struct ListaComprasWidgetExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ListaComprasAttributes.self) { context in
            // Lock Screen / banner
            
            HStack{
                
                Image(systemName: "cart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                
                VStack(alignment: .leading) {
                    Text("Total actual")
                    Text(String(format: "$%.2f", context.state.total))
                        .bold()
                }
                
                Spacer()
                
                VStack(alignment: .trailing){
                    Text("Cant. articulos")
                    Text("\(context.state.totalItems)")
                        .bold()
                }
            }
            
            
            .padding()
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded
                
                DynamicIslandExpandedRegion(.leading) {
                    Spacer()
                    Image(systemName: "cart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.white)
                        .padding(.leading, 12)
                }
                
                DynamicIslandExpandedRegion(.center) {
                    VStack {
                        Text("Total de tu lista")
                        Text(String(format: "$%.2f", context.state.total))
                            .font(.title2).bold()
                    }
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    VStack {
                        Text("Total de arts.")
                        Text("\(context.state.totalItems)")
                            .font(.title3).bold()
                    }
                }
            } compactLeading: {
                HStack{
                    Image(systemName: "cart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                    
                    Text("Arts. \(context.state.totalItems)")
                }
             
                
            } compactTrailing: {
                Text("Total: ")
                + Text(String(format: "$%.0f", context.state.total))
            } minimal: {
                Text(String(format: "$%.0f", context.state.total))
            }
        }
    }
}
