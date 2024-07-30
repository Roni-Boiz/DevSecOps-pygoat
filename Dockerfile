FROM python:3.11.0b1-buster

# set work directory
WORKDIR /app


# dependencies for psycopg2
# RUN apt-get update && apt-get install --no-install-recommends -y dnsutils=1:9.11.5.P4+dfsg-5.1+deb10u9 libpq-dev=11.16-0+deb10u1 python3-dev=3.7.3-1 \
#  && apt-get clean \
#  && rm -rf /var/lib/apt/lists/*
 RUN apt-get update && apt-get install --no-install-recommends -y dnsutils libpq-dev python3-dev \
 && apt-get clean
    

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1


# Install dependencies
RUN python -m pip install --no-cache-dir pip==22.0.4
COPY requirements.txt requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt
RUN pip install -r requirements.txt


# copy project
COPY . /app/


# install pygoat
EXPOSE 8000


RUN python3 /app/manage.py migrate
# WORKDIR /app/pygoat/
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "6", "pygoat.wsgi"]
CMD ["python3", "manage.py" ,"runserver", "0.0.0.0:8000"]