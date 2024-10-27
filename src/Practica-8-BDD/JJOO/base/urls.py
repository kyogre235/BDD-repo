from django.urls import path
from .views import AtletaAPIView, AtletaApiId, EntrenadorAPIView, EntrenadorApiId

"""asigna las urls para cada tipo de peticion"""
urlpatterns = [
    path('atleta/', AtletaAPIView.as_view()),
    path('entrenador/', EntrenadorAPIView.as_view() ),
    path('atletaid/', AtletaApiId.as_view()),
    path('entrenadorid/', EntrenadorApiId.as_view()),
]