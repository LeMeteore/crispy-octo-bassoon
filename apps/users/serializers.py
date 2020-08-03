from rest_framework import serializers
from . import models

# https://stackoverflow.com/questions/16857450/how-to-register-users-in-django-rest-framework

class UserSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        user = models.CustomUser.objects.create(
            username=validated_data['username']
        )
        user.set_password(validated_data['password'])
        user.save()

        return user
    
    class Meta:
        model = models.CustomUser
        fields = ('id', 'username', 'password', 'email', 'first_name', 'last_name')
        write_only_fields = ('password',)
        read_only_fields = ('id',)
