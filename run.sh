#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

set -e

command -v python3 >/dev/null 2>&1 || { echo >&2 "Python3 is required but not installed.  Aborting."; exit 1; }
command -v virtualenv >/dev/null 2>&1 || { python3 -m pip install --user virtualenv; }

gitignore() {
    echo -e "${YELLOW}♠︎ Generating .gitignore file${NC}"
    cat > .gitignore << EOL
.vscode
__pycache__
*.pyc
.venv
.env
EOL
}

createAuditorViews() {
    echo -e "${YELLOW}🔧 Creating auditor views${NC}"
    touch auditor/auditor/views.py
    cat > auditor/auditor/views.py << EOL
from django.shortcuts import render
from persons.models import Person

def main(request):
    return render(request, 'main.html')

def persons(request):  # Now in auditor/views.py
    persons = Person.objects.all()
    return render(request, 'persons.html', {'persons': persons})

def details(request, id):  # Now in auditor/views.py
    person = Person.objects.get(id=id)
    return render(request, 'details.html', {'person': person})
EOL
}

createUrlPersons() {
    echo -e "${YELLOW}🔧 Creating persons urls${NC}"
    touch auditor/persons/urls.py
    cat > auditor/persons/urls.py << EOL
from django.urls import path
from . import views

urlpatterns = [
    path('persons/', views.persons, name='persons'),
    path('persons/<int:id>/', views.details, name='details'), 
    path('', views.main, name='main'), 
]
EOL
}

createModels(){
    echo -e "${YELLOW}🔧 Creating persons models${NC}"
    rm auditor/persons/models.py
    touch auditor/persons/models.py
    cat > auditor/persons/models.py << EOL
from django.db import models

class Person(models.Model):
    firstname = models.CharField(max_length=255)
    lastname = models.CharField(max_length=255)
    email = models.CharField(max_length=255)
    jobTitle = models.CharField(max_length=255)

EOL
}

createViews(){
    echo -e "${YELLOW}🔧 Creating persons views${NC}"
    rm auditor/persons/views.py
    touch auditor/persons/views.py
    cat > auditor/persons/views.py << EOL
from django.http import HttpResponse
from django.template import loader
from .models import Person

def persons(request):
    persons = Person.objects.all().values()
    template = loader.get_template('persons.html')
    context = {
        'persons': persons,
    }
    return HttpResponse(template.render(context, request))

def details(request, id):
    person = Person.objects.get(id=id)
    template = loader.get_template('details.html')
    context = {
        'person': person,
    }
    return HttpResponse(template.render(context, request))

def main(request):
    template = loader.get_template('main.html')
    return HttpResponse(template.render())

def testing(request):
    template = loader.get_template('template.html')
    context = {
        'fruits': ['Black', 'White', 'Yellow'],   
    }
    return HttpResponse(template.render(context, request))

EOL
}

createUrlAuditor() {
    echo -e "${YELLOW}🔧 Creating auditor urls${NC}"
    rm auditor/auditor/urls.py
    touch auditor/auditor/urls.py
    cat > auditor/auditor/urls.py << EOL
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls), 
    path('', include('persons.urls')), 
]

EOL
}

createAdmin() {
    echo -e "${YELLOW}🔧 Creating admin${NC}"
    rm auditor/persons/admin.py
    touch auditor/persons/admin.py
    cat > auditor/persons/admin.py << EOL
from django.contrib import admin
from .models import Person

class PersonAdmin(admin.ModelAdmin):
    list_display = ("firstname", "lastname", "jobTitle",)

admin.site.register(Person, PersonAdmin)

EOL
}

createSettings() {
    echo -e "${YELLOW}🔧 Modifying auditor settings${NC}"
    rm auditor/auditor/settings.py
    touch auditor/auditor/settings.py
    cat > auditor/auditor/settings.py << EOL
from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/4.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'django-insecure-6)&0vmqoo=lc-)k-5@wiw(-)-w%wl0s@77yl#4c4=$+ejt@kxo'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['*']

# Application definition
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'whitenoise.runserver_nostatic',
    'django.contrib.staticfiles',
    'persons'
]

MIDDLEWARE = [
    'whitenoise.middleware.WhiteNoiseMiddleware', 
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'auditor.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'auditor.wsgi.application'

# Database
# https://docs.djangoproject.com/en/4.2/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

# Password validation
# https://docs.djangoproject.com/en/4.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

# Internationalization
# https://docs.djangoproject.com/en/4.2/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_TZ = True

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/4.2/howto/static-files/

STATIC_URL = 'static/'
STATIC_ROOT = BASE_DIR / 'staticfiles' 

STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'

# Default primary key field type
# https://docs.djangoproject.com/en/4.2/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
 
EOL
}

createTemplates() {
    echo -e "${YELLOW}🔧 Creating templates${NC}"
    mkdir auditor/persons/templates
    touch auditor/persons/templates/master.html
    cat > auditor/persons/templates/master.html << EOL
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

EOL

    touch auditor/persons/templates/persons.html
    cat > auditor/persons/templates/persons.html << EOL
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

EOL

    touch auditor/persons/templates/details.html
    cat > auditor/persons/templates/details.html << EOL
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

EOL

    touch auditor/persons/templates/main.html
    cat > auditor/persons/templates/main.html << EOL
{% extends "master.html" %}

{% block title %}
My app
{% endblock %}


{% block content %}
<h1>My app</h1>

<h3>Persons</h3>

<p>Check out all our <a href="persons/">persons</a></p>

{% endblock %}

EOL

    touch auditor/persons/templates/404.html
    cat > auditor/persons/templates/404.html << EOL
<!DOCTYPE html>
<html>
<title>Wrong address</title>
<body>

<h1>Ooops!</h1>

<h2>I cannot find the file you requested!</h2>

</body>
</html>

EOL
}

createSuperUser() {
    echo -e "${YELLOW}🔧 Creating Admin User${NC}"
    cd auditor
    python3 manage.py makemigrations persons
    python3 manage.py migrate
    python3 manage.py createsuperuser

}

runServer() {
    echo -e "${YELLOW}🔧 Setting server${NC}"
    pip install whitenoise
    python3 manage.py runserver
}

main() {
    echo -e "${YELLOW}🔧 Auditor Application Initialization${NC}"

    touch .gitignore .env
    gitignore

    python3 -m venv .venv
    source .venv/bin/activate
    pip install --upgrade pip setuptools wheel
    pip install --upgrade pip
    pip install django whitenoise django-bootstrap-v5

    #start Django project
    django-admin startproject auditor

    #move to project directory
    cd auditor

    #start new app
    python3 manage.py startapp persons

    #create urls in persons app
    cd ..
    createAuditorViews
    createUrlPersons
    createModels
    createViews
    createAdmin
    createUrlAuditor
    createSettings
    createTemplates
    createSuperUser
    runServer

    echo -e "${GREEN}🚀 Run 'python3 manage.py runserver' inside auditor${NC}"
    echo -e "${GREEN}🚀 Run 'python3 manage.py createsuperuser' to create a new admin user"
    echo -e "${GREEN}🚀 Then open admin at http://127.0.0.1:8000/admin"

}

main