from rest_framework import serializers
from .models import Atleta, Entrenador


class AtletaSerializer(serializers.ModelSerializer):
    """
        serializador para la clase atleta
    """
    class Meta:
        model = Atleta
        fields = ['idolimpicoa','idolimpicoe','triclave','nombre','apellidopaterno','apellidomaterno','fechanacimiento','genero']

class EntrenadorSerializer(serializers.ModelSerializer):
    """
            serializador para la clase entrenador
        """
    class Meta:
        model = Entrenador
        fields = ['idolimpicoe','nombre','apellidopaterno','apellidomaterno','fechanacimiento','genero']