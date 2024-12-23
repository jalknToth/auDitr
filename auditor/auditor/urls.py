from django.urls import path
from . import views

urlpatterns = [
    path('', views.main, name='main'),
    path('persons/', views.persons, name='persons'),
    path('persons/details/<int:id>', views.details, name='details'),
]

