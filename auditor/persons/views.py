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

