from django.db import models

# Create your models here.
class Atleta (models.Model):
    """
        Modelo que representa a un atleta olímpico.

        Attributes:
            idolimpicoa (BigIntegerField): Identificador único del atleta, clave primaria.
            idolimpicoe (BigIntegerField): Identificador del entrenador asociado al atleta.
            triclave (CharField): Clave de tres caracteres para el atleta.
            nombre (TextField): Nombre del atleta.
            apellidopaterno (TextField): Apellido paterno del atleta.
            apellidomaterno (TextField): Apellido materno del atleta.
            fechanacimiento (DateField): Fecha de nacimiento del atleta.
            genero (CharField): Género del atleta ('M' para masculino, 'F' para femenino).

        Meta:
            db_table (str): Nombre de la tabla en la base de datos (`atleta`).
            ordering (list): Lista de campos para ordenar (`idolimpicoa`).
    """
    idolimpicoa = models.BigIntegerField(primary_key=True)
    idolimpicoe = models.BigIntegerField()
    triclave = models.CharField(max_length=3)
    nombre = models.TextField()
    apellidopaterno = models.TextField()
    apellidomaterno = models.TextField()
    fechanacimiento = models.DateField()
    genero = models.CharField(max_length=1)
    class Meta:
        db_table = 'atleta'
        ordering = ['idolimpicoa']

class Entrenador (models.Model):
    """
        Modelo que representa a un entrenador olímpico.

        Attributes:
            idolimpicoe (BigIntegerField): Identificador único del entrenador, clave primaria.
            nombre (TextField): Nombre del entrenador.
            apellidopaterno (TextField): Apellido paterno del entrenador.
            apellidomaterno (TextField): Apellido materno del entrenador.
            fechanacimiento (DateField): Fecha de nacimiento del entrenador.
            genero (CharField): Género del entrenador ('M' para masculino, 'F' para femenino).

        Meta:
            db_table (str): Nombre de la tabla en la base de datos (`entrenador`).
            ordering (list): Lista de campos para ordenar (`idolimpicoe`).
    """

    idolimpicoe = models.BigIntegerField(primary_key=True)
    nombre = models.TextField()
    apellidopaterno = models.TextField()
    apellidomaterno = models.TextField()
    fechanacimiento = models.DateField()
    genero = models.CharField(max_length=1)
    class Meta:
        db_table = 'entrenador'
        ordering = ['idolimpicoe']

def __str__ (self):
    return self.name
