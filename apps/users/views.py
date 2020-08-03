from rest_framework import permissions, generics
from rest_framework.generics import CreateAPIView

from . import models
from . import serializers


class UserListView(generics.ListAPIView):
    queryset = models.CustomUser.objects.all()
    serializer_class = serializers.UserSerializer


class CreateUserView(CreateAPIView):
    model = models.CustomUser
    permission_classes = [
        permissions.IsAdminUser # Only admins can register a new user
    ]
    serializer_class = serializers.UserSerializer
