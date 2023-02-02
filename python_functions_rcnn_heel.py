from mrcnn.config import Config
from mrcnn.model import MaskRCNN

from mrcnn.visualize import display_instances, display_top_masks
from mrcnn.utils import extract_bboxes

import skimage.draw
from matplotlib import pyplot as plt

from mrcnn.model import load_image_gt
from mrcnn.model import mold_image
from mrcnn.utils import compute_ap
from numpy import expand_dims
from numpy import mean
from matplotlib.patches import Rectangle

# define the prediction configuration
class PredictionConfig(Config):
	# define the name of the configuration
	NAME = "hoof_heel_cfg_coco"
	# number of classes (background + heel 0 + heel 1 + heel 2)
	NUM_CLASSES = 1 + 3
	# Set batch size to 1 since we'll be running inference on
    # one image at a time. Batch size = GPU_COUNT * IMAGES_PER_GPU
	GPU_COUNT = 1
	IMAGES_PER_GPU = 1

# create config
cfg_he = PredictionConfig()
# define the model
model_he = MaskRCNN(mode='inference', model_dir='C:/Users/BhattacharjeeA/shiny-reticulate-app', config=cfg_he)

# load model weights
model_he.load_weights('C:/Users/BhattacharjeeA/shiny-reticulate-app/mask_rcnn_hoof_heel_cfg_coco_0020.h5', by_name=True)

#Function to test image
def test_heel_image(image_path=None):
    hoof_img = skimage.io.imread(image_path)
    detected = model_he.detect([hoof_img])
    results = detected[0]
    class_names = ['BG','side_heel_0', 'side_heel_1', 'side_heel_2']
    return display_instances(hoof_img, results['rois'], results['masks'], 
                  results['class_ids'], class_names, results['scores'])

def test_heel_result(image_path=None):
    hoof_img = skimage.io.imread(image_path)
    detected = model_he.detect([hoof_img])
    results = detected[0]
    class_names = ['BG','side_heel_0', 'side_heel_1', 'side_heel_2']
    return (f"Hoof conformation class is {class_names[results['class_ids'][0]]} and probabilty is {str(round(results['scores'][0],2))}")
