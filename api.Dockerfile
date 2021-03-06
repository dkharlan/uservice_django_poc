FROM python:3.6

RUN apt-get update && \
    apt-get --no-install-recommends upgrade --yes && \
    apt-get --no-install-recommends install mysql-client cron --yes

RUN mkdir -p /tmp/build
WORKDIR /tmp/build

RUN pip install gunicorn
COPY requirements.txt /tmp/build
RUN pip install -r requirements.txt

RUN mkdir -p /usr/src/app
COPY . /usr/src/app

WORKDIR /usr/src/app
RUN python manage.py migrate
RUN python manage.py shell --command "from django.contrib.auth.models import User; u = User.objects.create_user('testuser', 'test@nowhere.com', 'testpass'); u.save()"

EXPOSE 8000
CMD ./start.sh
