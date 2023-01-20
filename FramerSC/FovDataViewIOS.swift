//
//  FovDataViewIOS.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import SwiftUI

struct FovDataViewIOS: View {
    @Binding var fovData : FovData?
    
    
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 5) {
            Group {
                GridRow(alignment: .firstTextBaseline) {
                    Text("Distance")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("\(String(format: "%.2f", fovData?.distance_to_subject ?? 0))")
                        .gridColumnAlignment(.trailing)
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("m")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Spacer()
                    Text("Aperture")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("f/\(String(format: "%.1f", fovData?.aperture ?? 0))")
                        .gridColumnAlignment(.trailing)
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                }
            }
            Group {
                GridRow(alignment: .firstTextBaseline) {
                    Text("Field of view")
                        .foregroundColor(.white)
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    Text("").font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                    Text("").font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                    Spacer()
                    Text("Depth of field")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Focal length")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("\(fovData?.focal_length ?? 0)").gridColumnAlignment(.trailing)
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("mm")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Spacer()
                    Text("Total depth")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("\((fovData?.dof_total == 10000) ? "Infinite" : String(format: "%.2f", fovData?.dof_total ?? 0))")
                        .gridColumnAlignment(.trailing)
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("m")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("View angle")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("\(String(format: "%.2f", fovData?.fov_width_angle ?? 0))")
                        .gridColumnAlignment(.trailing)
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("°")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Spacer()
                    Text("Focus from")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("\(String(format: "%.2f", fovData?.dof_near_limit ?? 0))")
                        .gridColumnAlignment(.trailing)
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("m")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Field width")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("\(String(format: "%.2f", fovData?.fov_width ?? 0))")
                        .gridColumnAlignment(.trailing)
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("m")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Spacer()
                    Text("Focus to")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("\((fovData?.dof_far_limit == 10000) ? "Infinite" : String(format: "%.2f", fovData?.dof_far_limit ?? 0))")
                        .gridColumnAlignment(.trailing)
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("m")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Field height")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                    Text("\(String(format: "%.2f", fovData?.fov_height ?? 0))")
                        .gridColumnAlignment(.trailing)
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("m")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                }
                GridRow(alignment: .firstTextBaseline) {
                    Text("Covered height")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("\(String(format: "%.2f", fovData?.max_subject_height ?? 0))")
                        .gridColumnAlignment(.trailing)
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                    Text("m")
                        .font(.system(size: Constants.IOS_FOV_VIEW_FONT_SIZE))
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .background(.black.opacity(0.7))
        //.cornerRadius(10)
    }
}
