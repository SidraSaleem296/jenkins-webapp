# Use a lightweight Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the application files
COPY . .

# Install dependencies
RUN pip install flask

# Expose the application port
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]

