from django.shortcuts import render
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from .models import Atleta, Entrenador
from .serializers import AtletaSerializer, EntrenadorSerializer
import time
# Create your views here.


class AtletaAPIView(APIView):
    """
        API para gestionar operaciones generales sobre los atletas.

        Methods:
            get(): Devuelve una lista con todos los atletas.
            post(request): Crea un nuevo atleta con un ID basado en el tiempo en milisegundos.
    """

    def get(self,request):
        """
            Devuelve una lista con todos los atletas.

            Returns:
                Response: JSON con los datos de todos los atletas.
        """
        serializer = AtletaSerializer(Atleta.objects.all(), many=True)
        return Response(serializer.data)

    def post(self, request):
        """
            Crea un nuevo atleta en la base de datos.

            Args:
                request (Request): Objeto de solicitud HTTP, contiene los datos del atleta.

            Returns:
                Response: JSON con los datos del atleta creado o un error si la validación falla.
        """
        id = int(time.time() * 1000)
        request.data['idolimpicoa'] = id
        serializer = AtletaSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(status=status.HTTP_200_OK, data=serializer.data)


class AtletaApiId(APIView):
    """
        API para gestionar operaciones de un atleta específico por su ID.

        Methods:
            get(request, pk): Devuelve los datos de un atleta específico.
            put(request, pk): Actualiza los datos de un atleta específico.
            delete(request, pk): Elimina un atleta específico.
    """
    def get(self, request):
        """
            Devuelve los datos de un atleta específico.

            Args:
                request (Request): Objeto de solicitud HTTP.

            Returns:
                Response: JSON con los datos del atleta o un error si no se encuentra.
        """
        try:
            atleta = Atleta.objects.get(pk=request.data['idolimpicoa'])  # Busca el atleta por su pk
            # Devuelve los datos del atleta
            return Response({
                "id": atleta.pk,
                "idolimpicoe" : atleta.idolimpicoe,
                "triclave": atleta.triclave,
                "nombre": atleta.nombre,
                "apellidopaterno": atleta.apellidopaterno,
                "apellidomaterno": atleta.apellidomaterno,
                "fechanacimiento": atleta.fechanacimiento,
                "genero": atleta.genero,

            })
        except Atleta.DoesNotExist:
            return Response({"error": "Atleta no encontrado"}, status=status.HTTP_404_NOT_FOUND)

    def put(self, request):
        """
            Actualiza los datos de un atleta específico.

            Args:
                request (Request): Objeto de solicitud HTTP, contiene los datos actualizados.

            Returns:
                    Response: JSON con los datos del atleta actualizado o errores de validación.
        """
        try:
            # Busca el objeto en la base de datos por su pk
            instancia = Atleta.objects.get(pk=request.data['idolimpicoa'])
        except Atleta.DoesNotExist:
            return Response({"error": "Objeto no encontrado"}, status=status.HTTP_404_NOT_FOUND)


        # Actualiza la instancia usando los datos del request
        serializer = AtletaSerializer(instancia, data=request.data)

        if serializer.is_valid():
            serializer.save()  # Guarda los cambios en la base de datos
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request):
        """
            Elimina un atleta específico.

            Args:
                request (Request): Objeto de solicitud HTTP.

            Returns:
                Response: Mensaje de éxito o error si no se encuentra el atleta.
        """
        try:
            # Busca el objeto en la base de datos por su pk
            instancia = Atleta.objects.get(pk=request.data['idolimpicoa'])
        except Atleta.DoesNotExist:
            return Response({"error": "Objeto no encontrado"}, status=status.HTTP_404_NOT_FOUND)

        # Elimina el objeto
        instancia.delete()
        return Response({"message": "Objeto eliminado correctamente"}, status=status.HTTP_204_NO_CONTENT)

class EntrenadorAPIView(APIView):
    """
        API para gestionar operaciones generales sobre los entrenadores.

        Methods:
            get(request): Devuelve una lista con todos los entrenadores.
            post(request): Crea un nuevo entrenador con un ID basado en el tiempo en milisegundos.
    """
    def get(self,request):
        """
            Devuelve una lista con todos los entrenadores.

            Returns:
                Response: JSON con los datos de todos los entrenadores.
        """
        serializer = EntrenadorSerializer(Entrenador.objects.all(), many=True)
        return Response(serializer.data)

    def post(self, request):
        """
            Crea un nuevo entrenador en la base de datos.

            Args:
                request (Request): Objeto de solicitud HTTP, contiene los datos del entrenador.

            Returns:
                Response: JSON con los datos del entrenador creado o un error si la validación falla.
        """
        id = int(time.time() * 1000)
        request.data['idolimpicoe'] = id
        serializer = EntrenadorSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(status=status.HTTP_200_OK, data=serializer.data)

class EntrenadorApiId(APIView):
    """
        API para gestionar operaciones de un entrenador específico por su ID.

        Methods:
            get(request, pk): Devuelve los datos de un entrenador específico.
            put(request, pk): Actualiza los datos de un entrenador específico.
            delete(request, pk): Elimina un entrenador específico.
    """
    def get(self, request):
        """
            Devuelve los datos de un entrenador específico.

            Args:
                request (Request): Objeto de solicitud HTTP.

            Returns:
                Response: JSON con los datos del entrenador o un error si no se encuentra.
        """
        try:
            entrenador = Entrenador.objects.get(pk = request.data['idolimpicoe'])  # Busca el atleta por su pk
            # Devuelve los datos del atleta
            return Response({
                "id": entrenador.pk,
                "nombre": entrenador.nombre,
                "apellidopaterno": entrenador.apellidopaterno,
                "apellidomaterno": entrenador.apellidomaterno,
                "fechanacimiento": entrenador.fechanacimiento,
                "genero": entrenador.genero,
            })
        except Atleta.DoesNotExist:
            return Response({"error": "Atleta no encontrado"}, status=status.HTTP_404_NOT_FOUND)

    def put(self, request):
        """
            Actualiza los datos de un entrenador específico.

            Args:
                request (Request): Objeto de solicitud HTTP, contiene los datos actualizados.

            Returns:
                Response: JSON con los datos del entrenador actualizado o errores de validación.
        """
        try:
            # Busca el objeto en la base de datos por su pk
            instancia = Entrenador.objects.get(pk=request.data['idolimpicoe'])
        except Entrenador.DoesNotExist:
            return Response({"error": "Objeto no encontrado"}, status=status.HTTP_404_NOT_FOUND)


        # Actualiza la instancia usando los datos del request
        serializer = EntrenadorSerializer(instancia, data=request.data)

        if serializer.is_valid():
            serializer.save()  # Guarda los cambios en la base de datos
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request):
        """
            Elimina un entrenador específico.

            Args:
                request (Request): Objeto de solicitud HTTP.

            Returns:
                Response: Mensaje de éxito o error si no se encuentra el entrenador.
        """
        try:
            # Busca el objeto en la base de datos por su pk
            instancia = Entrenador.objects.get(pk=request.data['idolimpicoe'])
        except Entrenador.DoesNotExist:
            return Response({"error": "Objeto no encontrado"}, status=status.HTTP_404_NOT_FOUND)
        # Elimina el objeto
        instancia.delete()
        return Response({"message": "Objeto eliminado correctamente"}, status=status.HTTP_204_NO_CONTENT)