from django.db import models

class Person(models.Model):
    firstname = models.CharField(max_length=255)
    lastname = models.CharField(max_length=255)
    email = models.CharField(max_length=255)
    jobTitle = models.CharField(max_length=255)

