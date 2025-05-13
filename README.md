# Brain_Tumor_Detector_App_in_MATLAB

A simple MATLAB GUI application for detecting brain tumors from MRI images using basic image processing techniques such as **median filtering**, **Sobel edge detection**, and **region-based segmentation**.

## 🚀 Overview

This interactive app allows users to:

- Upload an MRI image.
- Apply a **Median Filter** to reduce noise.
- Perform **Edge Detection** using a custom Sobel operator.
- Detect tumor regions using **morphological processing** and **region properties**.

The tool is built using **MATLAB App Designer components**, providing an intuitive and visually interactive platform for beginners to explore medical image processing.

## 🔬 How It Works
### 🧠 1. What is MRI?
MRI (Magnetic Resonance Imaging) is a powerful imaging technique used in the medical field to generate detailed pictures of organs and soft tissues, especially the brain.

#### 📌 Key Points:

🧲 Uses strong magnetic fields and radio waves.

🧬 Excellent for visualizing soft tissues, like brain matter.

🎯 Helps identify abnormalities such as tumors.

🕳️ Tumors often appear as brighter or darker regions compared to the surrounding tissue.

✅ This contrast allows both doctors and computer programs to detect tumors efficiently.

### 🧹 2. Preprocessing with Median Filtering
Before processing, MRI images may contain noise (unwanted random variations in intensity). This can affect the accuracy of further steps like edge detection and segmentation.

#### 📌 Median Filtering to the Rescue:

📉 Replaces each pixel with the median of its surrounding pixels (usually in a 3x3 or 5x5 window).

❌ Removes salt-and-pepper noise without blurring the image.

✅ Preserves edges better than averaging filters.

🧼 Result: A cleaner, denoised image ready for further analysis.

### ✂️ 3. Edge Detection Using Sobel Operator
After denoising, the app detects edges—the boundaries where image intensity changes sharply. This is important to localize tumors and other structures.

#### 📌 Why Edges?

📐 Edges represent boundaries of different regions (like a tumor vs normal tissue).

🔍 Helps in identifying the shape and location of the tumor.

#### 📌 Sobel Operator:

➕ Applies two filters (horizontal & vertical gradients).

🧮 Computes the gradient magnitude to find where intensity changes the most.

🌟 Produces an image with highlighted boundaries (edges) in white or bright regions.

⚠️ At this stage, we don't yet know what the structure is—but we know where the boundaries are.

### 🎯 4. Tumor Segmentation and Detection
Now that the structure is visible, it's time to identify which part of the image actually contains the tumor.

#### 📌 Segmentation Process:

⚪ Thresholding: Convert the grayscale image into a binary image (white = possible tumor, black = background).

🧩 Labeling Regions: Use bwlabel to assign labels to all connected white regions.

📊 Analyze Regions: Use regionprops to measure each region’s:

Solidity: How compact or filled the shape is.

Area: How big the region is.

🧠 Select Tumor Region:

The largest, solid region is most likely the tumor.

Helps avoid small, irrelevant bright spots.

#### 📌 Post-processing:

🧱 Apply dilation to enlarge the region slightly for better visualization.

🟡 Overlay the tumor boundary in yellow on the filtered MRI for final display.

🎉 Result: The app clearly shows the tumor region on the MRI scan.

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
