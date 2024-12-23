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
