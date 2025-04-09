import tensorflow as tf

print("Versión de TensorFlow:", tf.__version__)
print("GPU detectada:", tf.config.list_physical_devices('GPU'))
