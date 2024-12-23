# Generated by Django 5.1.2 on 2024-10-26 03:09

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Atleta',
            fields=[
                ('idolimpicoa', models.BigIntegerField(primary_key=True, serialize=False)),
                ('idolimpicoe', models.BigIntegerField()),
                ('triclave', models.CharField(max_length=3)),
                ('nombre', models.TextField()),
                ('apellidopaterno', models.TextField()),
                ('apellidomaterno', models.TextField()),
                ('fechanacimiento', models.DateField()),
                ('genero', models.CharField(max_length=1)),
            ],
            options={
                'db_table': 'atleta',
                'ordering': ['idolimpicoa'],
            },
        ),
        migrations.CreateModel(
            name='Entrenador',
            fields=[
                ('idolimpicoe', models.BigIntegerField(primary_key=True, serialize=False)),
                ('nombre', models.TextField()),
                ('apellidopaterno', models.TextField()),
                ('apellidomaterno', models.TextField()),
                ('fechanacimiento', models.DateField()),
                ('genero', models.CharField(max_length=1)),
            ],
            options={
                'db_table': 'entrenador',
                'ordering': ['idolimpicoe'],
            },
        ),
    ]
