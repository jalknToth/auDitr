## Installation

1. **Clone the repository:**
```bash
git clone https://github.com/jalknToth/auDitr.git
```
2. **Run the setup script:**
```bash
chmod +x run.sh
./run.sh
```

9. **Update the database**
```
cd auditor
python3 manage.py makemigrations persons
```
10. **Run the migrate command**
```
python3 manage.py migrate
```
11. **open a Python shell**
```
python3 manage.py shell
```
12. **Import Person class**
```
>>> from persons.models import Person
```
13. **Add a record to the table**
```
>>> person = Person(firstname='Write name', lastname='write surname', email='', jobTitle='')
>>> person.save()
```
14. **See if the Person table got a person**
```
>>> Person.objects.all().values()
```
15. **Add multiple records by making a list**
```
>>> person1 = Person(firstname='name1', lastname='surname1', email='', jobtitle='')
>>> person2 = Person(firstname='name2', lastname='surname2', email='', jobtitle='')
>>> person3 = Person(firstname='name3', lastname='surname3', email='', jobtitle='')
>>> person4 = Person(firstname='name4', lastname='surname4', email='', jobtitle='')
>>> person5 = Person(firstname='name5', lastname='surname5', email='', jobtitle='')
>>> persons_list = [person1, person2, person3, person4, person5]
>>> for x in persons_list:
>>>   x.save()
```

16. **Create the templates**

auditor/persons/templates/master.html
```
<!DOCTYPE html>
<html>
<head>
<title>{% block title %}{% endblock %}</title>
</head>
<body>

{% block content %}
{% endblock %}

</body>
</html>
```
17. **Create Persons template**

auditor/persons/templates/persons.html:
```
{% extends "master.html" %}

{% block title %}
  My app - List of all persons
{% endblock %}


{% block content %}

  <p><a href="/">HOME</a></p>

  <h1>persons</h1>
  
  <ul>
    {% for x in persons %}
      <li><a href="details/{{ x.id }}">{{ x.firstname }} {{ x.lastname }}</a></li>
    {% endfor %}
  </ul>
{% endblock %}
```
18. **Create details template**

auditor/persons/template/details.html
```
{% extends "master.html" %}

{% block title %}
Details about {{ person.firstname }} {{ person.lastname }}
{% endblock %}


{% block content %}
<h1>{{ person.firstname }} {{ person.lastname }}</h1>

<p>Phone {{ person.phone }}</p>
<p>Job Title: {{ person.jobTitle }}</p>

<p>Back to <a href="/persons">Persons</a></p>

{% endblock %}
```
19. **Create main template**

auditor/persons/template/main.html:
```
{% extends "master.html" %}

{% block title %}
My app
{% endblock %}


{% block content %}
<h1>My app</h1>

<h3>Persons</h3>

<p>Check out all our <a href="persons/">persons</a></p>

{% endblock %}
```
20. **Create 404 error**
```
<!DOCTYPE html>
<html>
<title>Wrong address</title>
<body>

<h1>Ooops!</h1>

<h2>I cannot find the file you requested!</h2>

</body>
</html>
```
21. **Change this lines in settings.py**
```
DEBUG = False

ALLOWED_HOSTS = ['*']
```
22. **Create an User**
```
python3 manage.py createsuperuser
```
23. **Run the server**
```
python3 manage.py runserver
```
24. open 127.0.0.1:8000/admin/
<table>
  <tr>
    <td><img src="screenshots/login.png" alt="login" width="200px"></td>
    <td><img src="screenshots/admin.png" alt="admin" width="200px"></td>
  </tr>
</table>

