# FramerSC
A multiplatform Swift client for the framer api

FramerSC is a little tool to help you finding the right lens for a specific shot.
You can choose a focal length, an aperture, a sensor format and the orientation of the shot you are going to plan.
Then you can select the location of the camera by tapping/clicking on the screen. The camera location will be
marked with a 'C'. The subject can be selected by another tap/click and will be marked with an 'S'.
Now FramerSC will show you the field of view and the depth of field for your combination of values.

In addition you will find a little info overlay that shows additional information about
- Distance from camera to subject
- Aperture (if you have selected a TeleConverter, it will show the effective aperture)
- Focal length (if you have selected a TeleConverter, it will show you the effective focal length)
- The width of the field of view at the subject
- The height of the field of view at the subject
- The covered height, assuming the camera is at 1.6m (e.g. on a tripod)
- The total depth of field in meters
- The distance from where the image will be in focus
- The distance to which the image will be in focus

You can also copy the current settings to the clipboard in json format. So you can save this json file somewhere
and in case you would like to see it again you can copy the json text and paste it using the paste button.

The reset button will clear the markers and overlays.

MacOS version:
![MacOS](https://i.ibb.co/R3bcKVw/Framer-SC-Mac-OS.png)

iOS version:
![iOS](https://i.ibb.co/PD8TTK5/Framer-SC-i-OS.png)
