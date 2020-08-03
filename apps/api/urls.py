from django.urls import include, path
from rest_framework.authtoken import views

urlpatterns = [
    path('api-auth/', include('rest_framework.urls')),
    path('api-token-auth/', views.obtain_auth_token),
    path('users/', include('apps.users.urls')),
]
