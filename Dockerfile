# ultra-slim base
FROM python:3.11-alpine

# set working dir
WORKDIR /app

# copy only requirements first (cache optimization)
COPY requirements.txt .

# install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# copy app
COPY . .

# expose port
EXPOSE 8080

# run app (change if needed)
CMD ["python", "app.py"]
