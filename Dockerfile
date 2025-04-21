# Imagen base con Python 3.10
FROM python:3.10-slim

# Evita prompts de Debian
ENV DEBIAN_FRONTEND=noninteractive

# Instala dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Copia solo requirements (por eficiencia de cache)
COPY requirements.txt /tmp/requirements.txt

# Instala pip y dependencias de tu proyecto
RUN pip install --upgrade pip && pip install -r /tmp/requirements.txt

RUN pip install --upgrade pip && \
    pip install --extra-index-url https://download.pytorch.org/whl/cu118 -r /tmp/requirements.txt
