#!/bin/bash

VENV_NAME="ganvenv"
PYTHON_BIN="/usr/bin/python3.10"

echo "Creating virtual environment $VENV_NAME..."

# Check if the specified Python version is installed
if [ ! -f "$PYTHON_BIN" ]; then
  echo "Python 3.10.12 not found at $PYTHON_BIN"
  exit 1
fi

# Create the virtual environment
$PYTHON_BIN -m venv $VENV_NAME
if [ $? -ne 0 ]; then
  echo "Failed to create virtual environment"
  exit 1
fi

# Activate the virtual environment
source $VENV_NAME/bin/activate
if [ $? -ne 0 ]; then
  echo "Failed to activate virtual environment."
  exit 1
fi

echo "Virtual environment '$VENV_NAME' created and activated."

# Upgrade pip and install ipykernel
echo "Installing ipykernel..."
python3 -m pip install ipykernel -U --force-reinstall
if [ $? -ne 0 ]; then
  echo "Failed to install ipykernel."
  deactivate
  exit 1
fi

echo "Installing pytorch..."
python3 -m pip install torch==2.4.0 torchvision==0.19.0 torchaudio==2.4.0 --index-url https://download.pytorch.org/whl/cu118
if [ $? -ne 0 ]; then
  echo "Failed to install pytorch."
  deactivate
  exit 1
fi

echo "Installing gdown..."
pip install gdown
if [ $? -ne 0 ]; then
  echo "Failed to install gdown."
  deactivate
  exit 1
fi

cd ./stylegan2 || { echo "Failed to change directory to stylegan2"; deactivate; exit 1; }
gdown --folder https://drive.google.com/drive/folders/1SHek0J5O11o-lhC2KMwZG62JxpIhM0Rb?usp=sharing
cd ..

# Install additional packages
if [ -f "requirements.txt" ]; then
  echo "Installing packages from requirements.txt..."
  python3 -m pip install -r requirements.txt
  if [ $? -ne 0 ]; then
    echo "Failed to install packages from requirements.txt."
    deactivate
    exit 1
  fi
else
  echo "requirements.txt not found. Skipping package installation."
fi

# Uncomment and add any additional pip commands as needed
# echo "Installing additional packages..."
# python3 -m pip install scikit-learn
# python3 -m pip install requests
# python3 -m pip install click
# python3 -m pip install matplotlib

# Optionally freeze installed packages to requirements.txt
# echo "Freezing installed packages to requirements.txt..."
# python3 -m pip freeze > requirements.txt

# Prompt user for CUDA setup
read -p "Do you want to set up CUDA (yes/no)? " setup_cuda
if [[ "$setup_cuda" == "yes" || "$setup_cuda" == "y" ]]; then
  echo "Installing CUDA-related packages..."
  cd ~ || { echo "Failed to change directory to home"; deactivate; exit 1; }
  wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
  sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
  wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda-repo-ubuntu2204-11-8-local_11.8.0-520.61.05-1_amd64.deb
  sudo dpkg -i cuda-repo-ubuntu2204-11-8-local_11.8.0-520.61.05-1_amd64.deb
  sudo cp /var/cuda-repo-ubuntu2204-11-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
  sudo apt-get update
  sudo apt-get -y install cuda-toolkit-12-5
  sudo apt-get install -y nvidia-driver-555-open
  sudo apt-get install -y cuda-drivers-555
  echo "==============================================================================="
  echo "Reebot the machine then: "
  echo "Run commands nvidia-smi and nvcc -V to ensure that the installation is finished"
  echo "==============================================================================="
  if [ $? -ne 0 ]; then
    echo "Failed to install CUDA-related packages."
    deactivate
    exit 1
  fi
else
  echo "Skipping CUDA setup."
fi

echo "Setup complete."

# Optionally deactivate the virtual environment after setup
# deactivate

