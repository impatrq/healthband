# Generated by Django 4.2.4 on 2023-10-19 20:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('healthdatos', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='datos',
            name='BPM',
        ),
        migrations.RemoveField(
            model_name='datos',
            name='Glu',
        ),
        migrations.RemoveField(
            model_name='datos',
            name='Move',
        ),
        migrations.RemoveField(
            model_name='datos',
            name='Spo2',
        ),
        migrations.RemoveField(
            model_name='datos',
            name='Temp',
        ),
        migrations.AddField(
            model_name='datos',
            name='oxigenacion',
            field=models.IntegerField(default=None),
        ),
        migrations.AddField(
            model_name='datos',
            name='pulsos',
            field=models.IntegerField(default=None),
        ),
    ]
