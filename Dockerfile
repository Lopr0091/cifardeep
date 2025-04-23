# Imagen base con Python 3.10 slim
FROM python:3.10-slim

# Evita prompts interactivos durante apt install
ENV DEBIAN_FRONTEND=noninteractive

# Instala dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libgl1-mesa-glx \
    curl \
    build-essential \
    gcc \
    libffi-dev \
    libssl-dev \
    libyaml-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala Rust para compilar algunas dependencias
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Copia requirements.txt
COPY requirements.txt /tmp/requirements.txt

# Instala dependencias de Python (incluye PyTorch con CUDA)
RUN pip install --upgrade pip && \
    pip install --extra-index-url https://download.pytorch.org/whl/cu118 -r /tmp/requirements.txt

# Directorio de trabajo por defecto (útil si abres shell dentro del contenedor)
WORKDIR /app
