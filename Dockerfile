# Use Miniconda3 as the base image
FROM continuumio/miniconda3

# Set working directory
WORKDIR /app

# Update and install git
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Install mamba to improve conda environment management
RUN conda install -n base -c conda-forge mamba

# Clone the needed repository
RUN git clone https://github.com/jingbozhou/drug_combination_prediction.git

RUN mv /app/drug_combination_prediction/* /app/

# Copy the environment files
COPY requireEnvironment/environment_drugCombPro.yml /app/environment_drugCombPro.yml
COPY requireEnvironment/environment_infomax.yml /app/environment_infomax.yml

# Create the conda environments using mamba
RUN mamba env create -f environment_drugCombPro.yml && \
    mamba env create -f environment_infomax.yml

# Activate the environment and make sure it's the default when starting a shell session
RUN echo "source activate drugCombPro" > ~/.bashrc
ENV PATH /opt/conda/envs/drugCombPro/bin:$PATH

# Install additional packages via pip
RUN pip install dgl \
    scikit-optimize \
    numpy==1.22 \
    scikit-learn==1.0.2 \
    mordred \
    catboost \
    lightgbm \
    xgboost \
    graphviz \
    gdown

# Download the dataset
RUN gdown https://drive.google.com/file/d/1lDfHnsby79DQoabxNGfQbZFCc8SwTwJy/view?usp=share_link \
    mv Data.tar.gz /app/CombDrugModule/Data.tar.gz \
    tar zvxf /app/CombDrugModule/Data.tar.gz


# Copy application code (uncomment when required)
COPY . /app

# Set the command to execute when running the container
CMD ["bash"]
