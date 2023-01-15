//
//  PopupView.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import SwiftUI

struct FovDataViewMacOS: View {
    @Binding var fovData : FovData?
    
    
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 5) {
            Group {
                GridRow(alignment: .firstTextBaseline) {
                    Text("Distance")
                        .foregroundColor(.white)
                    Text("\(String(format: "%.2f", fovData?.distance_to_subject ?? 0))")
                        .foregroundColor(.white)
                        .gridColumnAlignment(.trailing)
                    Text("m")
                        .foregroundColor(.white)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Aperture")
                        .foregroundColor(.white)
                    Text("f/\(String(format: "%.1f", fovData?.aperture ?? 0))")
                        .foregroundColor(.white)
                        .gridColumnAlignment(.trailing)
                    Text("")
                        .foregroundColor(.white)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Field of view")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                }                
                GridRow(alignment: .firstTextBaseline) {
                    Text("Focal length")
                        .foregroundColor(.white)
                    Text("\(fovData?.focal_length ?? 0)")
                        .foregroundColor(.white)
                        .gridColumnAlignment(.trailing)
                    Text("mm")
                        .foregroundColor(.white)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("View angle")
                        .foregroundColor(.white)
                    Text("\(String(format: "%.2f", fovData?.fov_width_angle ?? 0))")
                        .foregroundColor(.white)
                        .gridColumnAlignment(.trailing)
                    Text("°")
                        .foregroundColor(.white)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Field width")
                        .foregroundColor(.white)
                    Text("\(String(format: "%.2f", fovData?.fov_width ?? 0))")
                        .foregroundColor(.white)
                        .gridColumnAlignment(.trailing)
                    Text("m")
                        .foregroundColor(.white)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Field height")
                        .foregroundColor(.white)
                    Text("\(String(format: "%.2f", fovData?.fov_height ?? 0))")
                        .foregroundColor(.white)
                        .gridColumnAlignment(.trailing)
                    Text("m")
                        .foregroundColor(.white)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Covered height")
                        .foregroundColor(.white)
                    Text("\(String(format: "%.2f", fovData?.max_subject_height ?? 0))")
                        .foregroundColor(.white)
                        .gridColumnAlignment(.trailing)
                    Text("m")
                        .foregroundColor(.white)
                }
            }
            Group {
                GridRow(alignment: .firstTextBaseline) {
                    Text("Depth of field")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Total depth")
                        .foregroundColor(.white)
                    Text("\((fovData?.dof_total == 10000) ? "Infinite" : String(format: "%.0f", fovData?.dof_total ?? 0))")
                        .foregroundColor(.white)
                        .gridColumnAlignment(.trailing)
                    Text("m")
                        .foregroundColor(.white)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Focus from")
                        .foregroundColor(.white)
                    Text("\(String(format: "%.0f", fovData?.dof_near_limit ?? 0))")
                        .foregroundColor(.white)
                        .gridColumnAlignment(.trailing)
                    Text("m")
                        .foregroundColor(.white)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Focus to")
                        .foregroundColor(.white)
                    Text("\((fovData?.dof_far_limit == 10000) ? "Infinite" : String(format: "%.0f", fovData?.dof_far_limit ?? 0))")
                        .foregroundColor(.white)
                        .gridColumnAlignment(.trailing)
                    Text("m")
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .background(.black.opacity(0.7))
        .cornerRadius(10)
    }
}
