# Use official Python image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# # Install system dependencies
# RUN apt-get update && apt-get install -y \
#     --no-install-recommends \
#     && rm -rf /var/lib/apt/lists/*

# Copy requirements first (better caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY app.py .
COPY data.csv .

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Run the script
CMD ["python", "app.py"]