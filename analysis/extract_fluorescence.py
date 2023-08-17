# 1. Import libraries and define functions

import numpy as np
import cv2
import matplotlib.pyplot as plt
from scipy.signal import find_peaks
import pandas as pd

# 2. Read microscope video as avi file
## Video needs to be in the same folder as the program

vid_name = input("Type the name of the video file: \n")    # wait for user to provide file name
vid = cv2.VideoCapture(vid_name+'.avi')     # read the video file
success,frame = vid.read()

# 3. Extract and save frames from video

cnt = 0     # define a counter that counts the current number of frame that the code is going through
fr_name = ''.join([vid_name, "_frame"])     # define the first part of the name of each frame: "Name of video_frame"

while success:
    cv2.imwrite(fr_name+"%d.jpg" % cnt, frame)
    success, frame = vid.read()
    print('Read a new frame: ', success)
    cnt += 1

fr_num = cnt
print('\nNumber of frames in video: ',fr_num)

# 4. Show frame in figure and choose AOI

ex_img = cv2.imread(fr_name+"1.jpg",0) # change number "1" if you want to put another frame as the example image
print('\nThe example frame is:'+fr_name+"1.jpg") # change number "1" if you want to put another frame as the example image
plt.figure(figsize= (10,8))
plt.title('Define coordinates of AOI and click anywhere to exit', fontsize = '15')
plt.imshow(ex_img)
plt.show(block=False)
plt.waitforbuttonpress(-1)
plt.close()

print('\nEnter the pixels coordinates of AOI: \n')
print('Length x1:x2\n')

x1 = input('x1=')
x1 = int(x1)

x2 = input('x2=')
x2 = int(x2)

print('\nWidth y1:y2\n')

y1 = input('y1=')
y1 = int(y1)

y2 = input('y2=')
y2 = int(y2)

# 5. Read frames as grayscale images, crop regions of AOI and get average intensity of pixels in AOI

sgn = []
sgn_dev = []
num = 0

for i in range(fr_num):
    a = str(num)+".jpg"
    img = cv2.imread(r"C:\python\{fr_name}{a}".format(fr_name = fr_name, a=a) ,0)
    aoi = img[y1:y2,x1:x2]
    data = np.average(aoi)
    stdev = np.std(aoi)
    sgn.append(data)
    sgn_dev.append(stdev)
    num += 1

# 6. Check if all the frame data were acquired and inform user

if len(sgn) == fr_num & len(sgn_dev) == fr_num:
    print("\nAll data acquired")

else: print("\nSomething went wrong")


# 7. Save raw data of average intensity and standard deviation in csv file

frame_index = []

for i in range(fr_num):
    frame_index.append(i)

raw_dict = {'Frames': frame_index, 'Average Intensity': sgn,'Standard Deviation': sgn_dev}
raw = pd.DataFrame(raw_dict)

raw.to_csv (vid_name+'_Raw Data.csv', index = True, header=True)
print("\nCsv file of raw data created in the same folder")

