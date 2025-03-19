#!/usr/bin/python3

import torch

# device debugging
if torch.cuda.is_available():
    print("GPU")
    device_id = torch.cuda.current_device()
    try:
        device_name = torch.cuda.get_device_name(device_id)
    except:
        device_name = "Unknown"
    print("Device id: {}".format(device_id))
    print("Decide name: {}".format(device_name))
else:
    print("CPU")

