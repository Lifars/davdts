FROM python:3

WORKDIR /usr/src/app

RUN apt update && apt install sqlite3 -y
RUN pip install --no-cache-dir django

RUN django-admin startproject mysite
WORKDIR mysite
RUN python3 manage.py startapp polls

COPY mysite/urls.py mysite/urls.py
COPY polls/views.py polls/views.py
COPY polls/urls.py polls/urls.py
COPY db.sql .

# using pre-configured database instead of `python3 manage.py migrate`
# that's to use pre-configured admin user superuser with password Passw0rd!
# this also allows putting dummy admin_log record into the database
RUN sqlite3 db.sqlite3 < ./db.sql

EXPOSE 8000/tcp

CMD [ "python", "./manage.py", "runserver", "0.0.0.0:8000"]
