FROM amazonlinux:2023

# Set environment variables if needed (e.g., for non-interactive installs)
ENV DEBIAN_FRONTEND=noninteractive

# Copy the Tesseract installation script into the Docker image
RUN mkdir /install
COPY install_leptonica.sh /install/install_leptonica.sh

# Make sure the script is executable
RUN chmod +x /install/install_leptonica.sh

# Run the Tesseract installation script
RUN /install/install_leptonica.sh

# Ensure Tesseract is in the system path
RUN ldconfig

CMD [ "bash" ]
