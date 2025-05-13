# Brain_Tumor_Detector_App_in_MATLAB

A simple MATLAB GUI application for detecting brain tumors from MRI images using basic image processing techniques such as **median filtering**, **Sobel edge detection**, and **region-based segmentation**.

## 🚀 Overview

This interactive app allows users to:

- Upload an MRI image.
- Apply a **Median Filter** to reduce noise.
- Perform **Edge Detection** using a custom Sobel operator.
- Detect tumor regions using **morphological processing** and **region properties**.

The tool is built using **MATLAB App Designer components**, providing an intuitive and visually interactive platform for beginners to explore medical image processing.

## How It Works

**1. What is MRI?**
MRI (Magnetic Resonance Imaging) is a powerful medical imaging technique used to visualize the brain and other soft tissues. It works by using strong magnetic fields and radio waves to produce detailed images of organs and tissues inside the body. MRI is particularly useful for brain imaging because it offers excellent contrast between different soft tissues, which helps in identifying abnormalities like tumors.

In brain MRIs, a tumor typically appears as a region with different intensity (brighter or darker) compared to surrounding tissue. This contrast makes it possible to detect tumors visually and computationally.

**2. Preprocessing with Median Filtering**
MRI images often contain noise, which can obscure details and affect further analysis. To address this, the first step in processing is to remove the noise using a median filter.

Median filtering is a non-linear process used to remove noise while preserving edges. It works by sliding a small window (usually 3x3 or 5x5) over each pixel in the image and replacing the central pixel with the median value of the surrounding pixels. Unlike averaging filters, the median filter is very effective at removing salt-and-pepper noise without blurring edges.

This preprocessing step improves the clarity of the image, which is crucial for accurately detecting edges and segmenting tumor regions.

**3. Edge Detection Using Sobel Operator**
Once the image is denoised, the next step is to identify the edges of various structures within the brain. Edge detection highlights areas of the image where there is a sudden change in intensity—typically indicating boundaries between different tissues or between a tumor and normal brain matter.

This app uses the Sobel operator, a classical edge detection method that computes the gradient of image intensity. It uses two 3x3 kernels (for horizontal and vertical gradients), then combines these to estimate the magnitude of the gradient at each point in the image. The result is an image where bright lines indicate edges.

Detecting edges helps localize the boundaries of the tumor and supports more accurate segmentation.

**4. Tumor Segmentation and Detection**
After identifying the edges, the app proceeds to detect the tumor by segmenting the image into regions.

The segmentation process involves:

Thresholding the filtered grayscale image into a binary image, where bright areas (likely tumors) become white and the rest black.

Labeling the connected white regions using bwlabel, which assigns a unique label to each connected component.

Analyzing these labeled regions using regionprops, which extracts features like area and solidity.

The algorithm selects the most solid and largest region under the assumption that tumors are usually solid and prominent in size.

The detected tumor region is then dilated slightly to make it more visible, and its boundary is traced and overlaid in yellow on the original image.

This method is rule-based and straightforward, offering a transparent and explainable approach to tumor detection suitable for educational purposes.

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

![image](https://github.com/user-attachments/assets/f0de53cf-6000-4f56-9230-83e897367821)


### 🧠 Tumor Detection Example

![image](https://github.com/user-attachments/assets/4add31b6-8ff1-4b3e-ba8b-fcf094f11c04)


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
