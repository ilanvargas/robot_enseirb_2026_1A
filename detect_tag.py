import cv2

# Sélection du dictionnaire ArUco utilisé
aruco_dict = cv2.aruco.getPredefinedDictionary(cv2.aruco.DICT_4X4_100)
# Paramètres du détecteur
aruco_params = cv2.aruco.DetectorParameters()
# Créer le détecteur
detector = cv2.aruco.ArucoDetector(aruco_dict, aruco_params)

tags = ((),)
current_frame = None
frame_count = 0

def open_camera():
    cap = cv2.VideoCapture(0, cv2.CAP_V4L2)
    if not cap.isOpened():
        print("❌ Impossible to open camera")
        return
    print("✅ Camera opened succesfully")

    return cap

def update_frame(cap):
    global current_frame, file_mode, im_path, frame_count
    frame_count += 1
    if file_mode:
        #Read image as a captured frame
        current_frame = cv2.imread(im_path)
    else:
        # Frame capture
        current_frame = cap.read()[1]
    #Take black and white version of the image
    current_frame = cv2.cvtColor(current_frame, cv2.COLOR_BGR2GRAY)



def find_tags():
    global current_frame, tags
    tags = detector.detectMarkers(current_frame)[0:1]


def debug_show_found_tags():
    global tags, current_frame
    print(tags)
    if tags == ((),):
        return
    cv2.aruco.drawDetectedMarkers(current_frame, *tags)

    cv2.imwrite(im_path, current_frame)

    print("Ouverture de la fenêtre d'affichage")
    cv2.imshow("Flux camera", current_frame)
    cv2.waitKey(1)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
    print("Fermeture de la fenêtre d'affichage")

make_path_name = lambda\
    im_path_patern : im_path_patern.replace("%d", str(frame_count))


if __name__ == "__main__":
    use_saved_img_if_no_cam = True
    cap = open_camera()
    file_mode = (cap == None) and use_saved_img_if_no_cam
    if file_mode:
        im_path_patern = input("No cam found default img path to use >")
    
    for i in range(1):
        # 1st test
        if file_mode:
            im_path = make_path_name(im_path_patern)
        update_frame(cap)
        find_tags()
        debug_show_found_tags()

    if cap != None:
        cap.release()


