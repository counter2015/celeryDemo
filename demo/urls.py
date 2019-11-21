from django.urls import path
from . import views

app_name = 'demo'
urlpatterns = [
    path('', views.index, name='index'),
    path('calc/', views.calc, name='calc'),
    path('listenToTask/', views.check_status, name="listenToTask"),
]
