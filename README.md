# Brain_Tumor_Detector_App_in_MATLAB

# Brain Tumor Detector App 🧠🔍

A simple MATLAB GUI application for detecting brain tumors from MRI images using basic image processing techniques such as **median filtering**, **Sobel edge detection**, and **region-based segmentation**.

## 🚀 Overview

This interactive app allows users to:

- Upload an MRI image.
- Apply a **Median Filter** to reduce noise.
- Perform **Edge Detection** using a custom Sobel operator.
- Detect tumor regions using **morphological processing** and **region properties**.

The tool is built using **MATLAB App Designer components**, providing an intuitive and visually interactive platform for beginners to explore medical image processing.

## ✨ Features

- 🖼️ **Load grayscale or RGB MRI scans**
- 🧹 **Noise reduction** using median filtering
- 🧾 **Custom Sobel Edge Detection**
- 🧠 **Tumor region segmentation**
- 🖱️ **Interactive GUI** with reset and step-by-step processing

## 🛠️ Requirements

- MATLAB R2021a or newer (App Designer supported)
- Image Processing Toolbox

## 📦 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/Brain-Tumor-Detector-App.git
   cd Brain-Tumor-Detector-App
````

2. Open `Brain_Tumor_Detector_App_2.m` in MATLAB.

3. Click **Run** to launch the app GUI.

## 🎮 Usage Instructions

1. Click on **"Select MRI"** to load an image (`.jpg`, `.png`, `.bmp`).
2. Click **"Median Filter"** to denoise the image.
3. Click **"Edge Detect"** to extract boundaries using the Sobel operator.
4. Click **"Detect Tumor"** to highlight the largest solid region assumed to be a tumor.
5. Click **"Reset"** to clear all images and restart the process.

## 📷 Screenshots

### 🏠 Main Interface

![Main GUI](screenshots/main_gui.png)

### 🧠 Tumor Detection Example

![Tumor Segmentation](screenshots/tumor_segmentation.png)

---

## 🧪 Example MRI Images

Include some example MRI scans in the `examples/` folder for testing:

* `examples/sample1.png`
* `examples/sample2.jpg`

---

## 📂 Project Structure

```plaintext
Brain-Tumor-Detector-App/
│
├── Brain_Tumor_Detector_App_2.m     # Main app code
├── README.md                        # Project documentation
├── examples/                        # Sample MRI images (optional)
└── screenshots/                     # GUI screenshots (optional)
```


## 🧠 How Tumor is Detected?

1. The image is **thresholded** to create a binary mask.
2. Connected components are **labeled**.
3. Each region’s **solidity and area** are analyzed.
4. The **largest solid region** is assumed to be the tumor.
5. The tumor region is **highlighted** with a yellow boundary.

## 📜 License

This project is licensed under the **MIT License**. See `LICENSE` for more details.

## 🧑‍💻 Author

K. Lohitha Reddy

### 📌 Notes for You:
- Replace `yourusername` with your actual GitHub username.
- Add actual image files in the `screenshots/` and `examples/` folders if you'd like to use those sections.
- You can also provide `.mlapp` version if you convert it later using MATLAB App Designer.

Let me know if you’d like help generating those screenshots or converting to `.mlapp` format!

# Results
![image](https://github.com/user-attachments/assets/4add31b6-8ff1-4b3e-ba8b-fcf094f11c04)
