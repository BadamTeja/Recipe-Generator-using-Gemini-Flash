FROM python:3.11-slim

WORKDIR /app

# install system dependencies (important for chromadb, numpy, etc.)
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080

CMD ["streamlit", "run", "app2.py", "--server.port=8080", "--server.address=0.0.0.0"]
