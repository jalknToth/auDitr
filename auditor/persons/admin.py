from django.contrib import admin
from .models import Person

class PersonAdmin(admin.ModelAdmin):
    list_display = ("firstname", "lastname", "jobTitle",)

admin.site.register(Person, PersonAdmin)

