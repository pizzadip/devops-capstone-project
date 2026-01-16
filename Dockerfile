FROM python:3.9-slim

# Create non-root user
RUN useradd --create-home appuser

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source
COPY . .

# Fix permissions and switch user
RUN chown -R appuser:appuser /app
USER appuser

# Expose service port
EXPOSE 8080

# Run the service
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "service:app"]
