import detect_tag
import find_tag_3D
import numpy as np

arcuo_size = .1

path = "/home/aypiman/Documents/dev/robot 1A/test_vizion/im0.jpg"

pixel_per_meter_at_one_meter = 2268*0.739
center = (2268/2, 4032/2)


detect_tag.import_frame_from_file(path)
detect_tag.find_tags()

print(detect_tag.tags[0][0][0])

X_c = [
    np.array((
        (x - center[0]) / pixel_per_meter_at_one_meter,
        (y - center[1]) / pixel_per_meter_at_one_meter,
        1.
    ))
    for x, y in detect_tag.tags[0][0][0]
]

PX = [*find_tag_3D.compute_tag_points(*X_c, arcuo_size)]

for PX in PX:
    print(PX)

