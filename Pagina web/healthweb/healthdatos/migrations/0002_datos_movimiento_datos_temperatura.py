# Generated by Django 4.2.4 on 2023-10-24 11:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('healthdatos', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='datos',
            name='movimiento',
            field=models.CharField(max_length=30, null=True),
        ),
        migrations.AddField(
            model_name='datos',
            name='temperatura',
            field=models.FloatField(default=None, null=True),
        ),
    ]
