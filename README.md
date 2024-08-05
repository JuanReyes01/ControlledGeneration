# K-means used to find direction vectors in the latent space
## Overview
- [StyleGAN2-ADA](https://github.com/NVlabs/stylegan2-ada-pytorch?tab=readme-ov-file) was used as a starting point to create 2 image generation models.
- K-means is used as a unsupervised path to obtain latent space direction vectors for controlled generation
![carsVec](https://github.com/user-attachments/assets/16cbd539-e8b9-4ceb-842e-33b134112419)
- It is possible to search for 'Good' direction vectors by looking at the density of the clusters
![imgPerCluster](https://github.com/user-attachments/assets/b095d8d9-a4e0-42ea-bfc2-80afaaeeb09a)
- All vectors can be analized individually 
![carsProg](https://github.com/user-attachments/assets/60264a3d-6bcc-4964-a572-cae926b13778)



## Requirements (From [StyleGAN2](https://github.com/NVlabs/stylegan2-ada-pytorch?tab=readme-ov-file))

 - Linux and Windows are supported, but we recommend Linux for performance and compatibility reasons.
 - 1–8 high-end NVIDIA GPUs with at least 12 GB of memory. We have done all testing and development using NVIDIA DGX-1 with 8 Tesla V100 GPUs.
 - 64-bit Python 3.7 and PyTorch 1.7.1. See https://pytorch.org/ for PyTorch install instructions.
 - CUDA toolkit 11.0 or later. Use at least version 11.1 if running on RTX 3090. (Why is a separate CUDA toolkit installation required? See comments in #2.)
 - Python libraries: `pip install click requests tqdm pyspng ninja imageio-ffmpeg==0.4.3`. We use the Anaconda3 2020.11 distribution which installs most of these by default.

The code relies heavily on custom PyTorch extensions that are compiled on the fly using NVCC. On Windows, the compilation requires Microsoft Visual Studio. We recommend installing Visual Studio Community Edition and adding it into `PATH` using `"C:\Program Files (x86)\Microsoft Visual Studio\<VERSION>\Community\VC\Auxiliary\Build\vcvars64.bat"`.

## Repository Contents
 - **Notebook** showing basic usage of StyleGAN2-ADA with the FFHQ model
 - **Notebooks** where k-means was used to find latent directions
 - **Notebook** to experiment with individual directions
 - Setup **shell script** to install libraries (works as of august of 2024)

## Quickstart
> git clone https://github.com/JuanReyes01/ControlledGeneration <br>
cd ControlledGeneration <br>
sudo ./setup.sh <br>
code .

## Models direct download
[google drive](https://drive.google.com/drive/folders/1SHek0J5O11o-lhC2KMwZG62JxpIhM0Rb?usp=sharing)
 | Model | FID |
 |-------|-----|
 |Standford-Cars| 13.66|
 |Wine-Labels | 42|
 

